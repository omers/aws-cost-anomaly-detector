# AWS Cost Anomaly Detector 🚨

## Description

Never be surprised by your AWS bill again! This Terraform module automatically sets up AWS Cost Anomaly Detection to monitor your spending and alert you when unexpected cost increases occur.


## Key Features

- **Simple Deployment**: Intuitive and declarative Terraform module for cost anomaly detection.
- **Automated Configuration**: Automatically configures AWS Cost Explorer and anomaly detection settings.
- **Real-time Alerts**: Receive instant notifications for cost anomalies.
- **Cost Optimization**: Gain insights to optimize AWS spending and identify cost-saving opportunities.
- **Scalability**: Supports large-scale AWS environments with ease.

## Quick Start

```hcl
module "cost_anomaly_detection" {
  source  = "https://github.com/omers/aws-cost-anomaly-detector.git"
  
  region                = "us-west-2"
  environment           = "production"
  emails                = ["devops@example.com", "finance@example.com"]
  raise_amount_percent  = "20"
  raise_amount_absolute = "100"
  
  # Optional PagerDuty integration
  create_pagerduty      = true
  pagerduty_endpoint    = "https://events.pagerduty.com/integration/abcdef123456/enqueue"
  
  resource_tags = {
    ManagedBy = "Terraform"
    Project   = "CostOptimization"
  }
}
```

## Prerequisites

- Terraform v1.0+
- AWS account with appropriate permissions
- AWS provider v5.6.2 or later

## PagerDuty Setup

1. Create a new PagerDuty service with the **Amazon CloudWatch** integration type.
2. Copy the PagerDuty Integration URL to the `pagerduty_endpoint` input variable.
3. Set `create_pagerduty = true` in your module configuration.

## Module Documentation

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.6.2 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_ce_anomaly_monitor.anomaly_monitor](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/ce_anomaly_monitor) | resource |
| [aws_ce_anomaly_subscription.realtime_subscription](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/ce_anomaly_subscription) | resource |
| [aws_sns_topic.cost_anomaly_updates](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.pagerduty](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.topic_email_subscription](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/data-sources/iam_policy_document) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_pagerduty"></a> [create\_pagerduty](#input\_create\_pagerduty) | Set to true in order to send notifications to PagerDuty | `bool` | `false` | no |
| <a name="input_emails"></a> [emails](#input\_emails) | List of email addresses to notify | `list(any)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The account environment (Prod / Dev etc.) | `string` | n/a | yes |
| <a name="input_pagerduty_endpoint"></a> [pagerduty\_endpoint](#input\_pagerduty\_endpoint) | The PagerDuty HTTPS endpoint where SNS notifications will be sent to | `string` | n/a | yes |
| <a name="input_raise_amount_absolute"></a> [raise\_amount\_absolute](#input\_raise\_amount\_absolute) | The Absolut increase in USD to trigger the detector. (ANOMALY\_TOTAL\_IMPACT\_ABSOLUTE) | `string` | n/a | yes |
| <a name="input_raise_amount_percent"></a> [raise\_amount\_percent](#input\_raise\_amount\_percent) | An Expression object used to specify the anomalies that you want to generate alerts for. The precentage service cost increase than the expected | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags to set for all resources | `map(string)` | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_arn"></a> [sns\_arn](#output\_sns\_arn) | n/a |