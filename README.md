## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ce_anomaly_monitor.anomaly_monitor](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/ce_anomaly_monitor) | resource |
| [aws_ce_anomaly_subscription.realtime_subscription](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/ce_anomaly_subscription) | resource |
| [aws_sns_topic.cost_anomaly_updates](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.topic_email_subscription](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_emails"></a> [emails](#input\_emails) | List of email addresses to notify | `list(any)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The account environment (Prod / Dev etc.) | `string` | n/a | yes |
| <a name="input_raise_amount_percent"></a> [raise\_amount\_percent](#input\_raise\_amount\_percent) | An Expression object used to specify the anomalies that you want to generate alerts for. The precentage service cost increase than the expected | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |

## Outputs

No outputs.
