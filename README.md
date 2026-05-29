# AWS Cost Anomaly Detector

## Description

This Terraform module streamlines AWS cost management by automatically setting up AWS Cost Anomaly Detection. It continuously monitors your cloud expenses and instantly alerts you to unexpected cost spikes—helping you optimize your AWS billing, prevent overspending, and maintain tight control over your cloud budget. Whether you're looking to enhance cost monitoring, streamline AWS cost management, or integrate automated cost alerts into your infrastructure, this module is your key to a more predictable and efficient AWS spending strategy.

## Key Features

- **Simple Deployment**: Intuitive and declarative Terraform module for cost anomaly detection.
- **Automated Configuration**: Automatically configures AWS Cost Explorer and anomaly detection settings.
- **Real-time Alerts**: Receive instant notifications for cost anomalies.
- **Cost Optimization**: Gain insights to optimize AWS spending and identify cost-saving opportunities.
- **Scalability**: Supports large-scale AWS environments with ease.

## Quick Start

```hcl

terraform {
# Setup yor state backend here. 
# Either s3 / local
}


module "cost_anomaly_detection" {
  source  = "github.com/omers/aws-cost-anomaly-detector.git"
  
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

## Configuration Setup

1. Copy the example variables file to create your own configuration:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your specific values:
   - Update `region` to your target AWS region
   - Set `emails` to the recipients for notifications
   - Adjust `raise_amount_percent` and `raise_amount_absolute` thresholds as needed
   - Optionally configure PagerDuty integration

3. Validate your configuration:
   ```bash
   terraform validate
   ```

4. Preview the resources that will be created:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

**Note:** The `terraform.tfvars` file is excluded from version control to prevent committing sensitive information like email addresses and webhook URLs.

## PagerDuty Setup

1. Create a new PagerDuty service with the **Amazon CloudWatch** integration type.
2. Copy the PagerDuty Integration URL to the `pagerduty_endpoint` input variable.
3. Set `create_pagerduty = true` in your module configuration.

## Module Documentation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_ce_anomaly_monitor.anomaly_monitor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ce_anomaly_monitor) | resource |
| [aws_ce_anomaly_subscription.realtime_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ce_anomaly_subscription) | resource |
| [aws_sns_topic.cost_anomaly_updates](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.pagerduty](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.topic_email_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anomaly_monitor_name"></a> [anomaly\_monitor\_name](#input\_anomaly\_monitor\_name) | Name of the AWS Cost Anomaly Monitor | `string` | `"AWSServiceMonitor"` | no |
| <a name="input_anomaly_subscription_name"></a> [anomaly\_subscription\_name](#input\_anomaly\_subscription\_name) | Name of the AWS Cost Anomaly Subscription | `string` | `"RealtimeAnomalySubscription"` | no |
| <a name="input_create_pagerduty"></a> [create\_pagerduty](#input\_create\_pagerduty) | Set to true in order to send notifications to PagerDuty | `bool` | `false` | no |
| <a name="input_emails"></a> [emails](#input\_emails) | List of email addresses to notify | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The account environment (Prod / Dev etc.) | `string` | n/a | yes |
| <a name="input_pagerduty_endpoint"></a> [pagerduty\_endpoint](#input\_pagerduty\_endpoint) | The PagerDuty HTTPS endpoint where SNS notifications will be sent to. Required only if create_pagerduty is true. | `string` | `null` | no |
| <a name="input_raise_amount_absolute"></a> [raise\_amount\_absolute](#input\_raise\_amount\_absolute) | Dollar amount threshold in USD (e.g., '100' for $100) | `string` | n/a | yes |
| <a name="input_raise_amount_percent"></a> [raise\_amount\_percent](#input\_raise\_amount\_percent) | Percentage cost increase threshold (e.g., '20' for 20%) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags to set for all resources | `map(string)` | `{}` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | Name of the SNS topic for cost anomaly notifications | `string` | `"CostAnomalyUpdates"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_arn"></a> [sns\_arn](#output\_sns\_arn) | n/a |