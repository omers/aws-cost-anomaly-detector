# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AWS Cost Anomaly Detector is a Terraform module that automates AWS Cost Anomaly Detection setup. It creates SNS-based notification infrastructure to alert users (via email or PagerDuty) when AWS costs deviate from expected patterns.

## Architecture

The module creates a notification pipeline:
1. **AWS Cost Anomaly Monitor** (`aws_ce_anomaly_monitor`) — Dimensional monitor tracking cost anomalies by service
2. **AWS Cost Anomaly Subscription** (`aws_ce_anomaly_subscription`) — Triggers on cost spikes matching percentage or absolute dollar thresholds
3. **SNS Topic** (`aws_sns_topic`) — Encrypted notification hub with retry/throttling policies
4. **Subscriptions** — Email and optional PagerDuty endpoint subscriptions
5. **IAM Policy** — Permits AWS Cost Alert service (`costalerts.amazonaws.com`) to publish to the SNS topic

Key design decisions:
- Thresholds use OR logic: anomalies matching *either* percentage OR absolute increase trigger alerts
- SNS topic uses AWS-managed KMS encryption for security
- Delivery policy enforces linear backoff with 3 retries (suitable for webhook-style consumers like PagerDuty)
- Email subscriptions require manual confirmation by subscribers

## Development Commands

**Terraform validation & planning:**
```bash
terraform init          # Initialize workspace (downloads providers, loads remote state)
terraform validate      # Check syntax and required arguments
terraform plan          # Preview what will be created/changed/destroyed
terraform apply         # Apply changes to AWS
terraform destroy       # Tear down all resources
```

**Security scanning (runs in CI via tfsec):**
```bash
tfsec .                 # Run tfsec locally to catch security issues before commit
```

**State management:**
```bash
terraform state list    # Show all managed resources
terraform state show <resource>  # Show a specific resource's state
```

## File Structure

- `main.tf` — Core resources: SNS topic, anomaly monitor/subscription, IAM policies
- `variables.tf` — Input variables for region, environment, emails, thresholds, PagerDuty config
- `provider.tf` — AWS provider version constraint (~>5.0) and S3 backend configuration
- `outputs.tf` — Exports SNS topic ARN for downstream references
- `README.md` — User-facing documentation with Quick Start and module reference

## Key Variables & Configuration

- `region` — AWS region (validated against AWS naming pattern)
- `environment` — Deployment environment label (e.g., "production")
- `emails` — List of email addresses for notifications (require manual subscription confirmation)
- `raise_amount_percent` — Percentage cost increase threshold for alerts (e.g., "20" for 20%)
- `raise_amount_absolute` — Dollar amount increase threshold (e.g., "100" for $100)
- `create_pagerduty` — Boolean to conditionally create PagerDuty subscription
- `pagerduty_endpoint` — HTTPS webhook URL for PagerDuty integration
- `resource_tags` — Map of tags applied to all resources via provider default_tags

## Before Committing

1. Run `terraform validate` to catch syntax errors
2. Run `tfsec .` to check for security issues (e.g., unencrypted SNS, overly permissive policies)
3. Use `terraform plan` to preview changes before pushing
4. Ensure the S3 backend is configured in `provider.tf` before applying (local state only acceptable for testing)

## Common Troubleshooting

**"terraform init" fails:** Verify AWS credentials are set and the S3 backend path exists.
**Email subscriptions don't work:** Recipients must click the confirmation link sent by AWS SNS; unconfirmed subscriptions don't receive alerts.
**PagerDuty integration not triggering:** Check that `endpoint_auto_confirms = true` is set in the subscription and the endpoint URL is correctly copied from PagerDuty.
