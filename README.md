# Description:
The AWS Cost Anomaly Detection Terraform module is a powerful tool designed to simplify the management of cost anomaly detection in your Amazon Web Services (AWS) infrastructure. This module leverages the flexibility and scalability of Terraform to automate the deployment and configuration of the necessary AWS resources, allowing you to effortlessly monitor and identify unusual spending patterns in your cloud environment.

By utilizing the AWS Cost Anomaly Detection Terraform module, you can proactively detect and investigate unexpected changes in your AWS costs, enabling you to optimize your cloud spending and ensure cost efficiency. The module integrates seamlessly with AWS Cost Explorer and leverages its machine learning capabilities to analyze historical cost data and identify anomalies, such as sudden cost spikes or unusual usage patterns.

# Key Features:

## Simple Deployment:
The Terraform module provides an intuitive and declarative approach to infrastructure management, allowing you to easily deploy the necessary resources for cost anomaly detection.
Automated Configuration: With this module, you can automate the configuration of AWS Cost Explorer and set up the required anomaly detection settings without manual intervention.
## Real-time Alerts:
Receive real-time notifications when cost anomalies are detected, enabling you to promptly investigate and take appropriate actions to mitigate any potential issues.
Cost Optimization: By leveraging the insights provided by the module, you can optimize your AWS spending, identify cost-saving opportunities, and ensure better cost control for your cloud infrastructure.
## Scalability:
The module is designed to handle large-scale AWS environments, accommodating growing workloads and enabling you to seamlessly monitor cost anomalies across your entire infrastructure.
Whether you are a small startup or a large enterprise, the AWS Cost Anomaly Detection Terraform module offers an efficient and reliable solution to automate the detection and management of cost anomalies in your AWS environment. Start using this module today and gain valuable insights into your cloud spending, empowering you to make informed decisions and optimize your AWS costs.

# PagerDuty setup
PagerDuty service shall be an Amazon Cloudwatch service. Once created you should copy the PagerDuty Integration URL to the endpoint_url input variable
# Module documentation:

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
| [aws_sns_topic_subscription.pagerduty](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.topic_email_subscription](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/5.6.2/docs/data-sources/iam_policy_document) | data source |

## Inputs

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

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_arn"></a> [sns\_arn](#output\_sns\_arn) | n/a |