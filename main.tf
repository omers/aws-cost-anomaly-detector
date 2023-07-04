data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "cost_anomaly_updates" {
  name              = "CostAnomalyUpdates"
  kms_master_key_id = "alias/aws/sns"
  delivery_policy = jsonencode({
    "http" : {
      "defaultHealthyRetryPolicy" : {
        "minDelayTarget" : 20,
        "maxDelayTarget" : 20,
        "numRetries" : 3,
        "numMaxDelayRetries" : 0,
        "numNoDelayRetries" : 0,
        "numMinDelayRetries" : 0,
        "backoffFunction" : "linear"
      },
      "disableSubscriptionOverrides" : false,
      "defaultThrottlePolicy" : {
        "maxReceivesPerSecond" : 1
      }
    }
  })
}

resource "aws_sns_topic_subscription" "topic_email_subscription" {
  count     = length(var.emails)
  topic_arn = aws_sns_topic.cost_anomaly_updates.arn
  protocol  = "email"
  endpoint  = var.emails[count.index]
}

resource "aws_sns_topic_subscription" "pagerduty" {
  count                  = var.create_pagerduty ? 1 : 0
  endpoint               = var.pagerduty_endpoint
  endpoint_auto_confirms = true
  protocol               = "https"
  topic_arn              = aws_sns_topic.cost_anomaly_updates.arn
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    sid = "AWSAnomalyDetectionSNSPublishingPermissions"

    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["costalerts.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.cost_anomaly_updates.arn,
    ]
  }

  statement {
    sid = "__default_statement_ID"

    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.cost_anomaly_updates.arn,
    ]
  }
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.cost_anomaly_updates.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_ce_anomaly_monitor" "anomaly_monitor" {
  name              = "AWSServiceMonitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
}

resource "aws_ce_anomaly_subscription" "realtime_subscription" {
  name      = "RealtimeAnomalySubscription"
  frequency = "IMMEDIATE"
  threshold_expression {
    or {
      dimension {
        key           = "ANOMALY_TOTAL_IMPACT_PERCENTAGE"
        values        = [var.raise_amount_percent]
        match_options = ["GREATER_THAN_OR_EQUAL"]
      }
    }
    or {
      dimension {
        key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
        values        = [var.raise_amount_absolute]
        match_options = ["GREATER_THAN_OR_EQUAL"]
      }
    }
  }
  monitor_arn_list = [
    aws_ce_anomaly_monitor.anomaly_monitor.arn,
  ]

  subscriber {
    type    = "SNS"
    address = aws_sns_topic.cost_anomaly_updates.arn
  }
  depends_on = [
    aws_sns_topic_policy.default,
  ]
}
