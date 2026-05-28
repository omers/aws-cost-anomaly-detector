variable "environment" {
  type        = string
  description = "The account environment (Prod / Dev etc.)"
}

variable "region" {
  type        = string
  description = "AWS Region"
  validation {
    condition     = can(regex("[a-z][a-z]-[a-z]+-[1-9]", var.region))
    error_message = "Must be valid AWS Region names."
  }
}

variable "emails" {
  type        = list(string)
  description = "List of email addresses to notify"
}

variable "raise_amount_percent" {
  type        = string
  description = "Percentage cost increase threshold (e.g., '20' for 20%)"

  validation {
    condition     = can(tonumber(var.raise_amount_percent)) && tonumber(var.raise_amount_percent) > 0
    error_message = "Must be a positive number."
  }
}

variable "raise_amount_absolute" {
  type        = string
  description = "Dollar amount threshold in USD (e.g., '100' for $100)"

  validation {
    condition     = can(tonumber(var.raise_amount_absolute)) && tonumber(var.raise_amount_absolute) > 0
    error_message = "Must be a positive number."
  }
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}

variable "sns_topic_name" {
  type        = string
  default     = "CostAnomalyUpdates"
  description = "Name of the SNS topic for cost anomaly notifications"
}

variable "anomaly_monitor_name" {
  type        = string
  default     = "AWSServiceMonitor"
  description = "Name of the AWS Cost Anomaly Monitor"
}

variable "anomaly_subscription_name" {
  type        = string
  default     = "RealtimeAnomalySubscription"
  description = "Name of the AWS Cost Anomaly Subscription"
}

variable "create_pagerduty" {
  type        = bool
  default     = false
  description = "Set to true to send notifications to PagerDuty"
}

variable "pagerduty_endpoint" {
  description = "The PagerDuty HTTPS endpoint where SNS notifications will be sent to. Required only if create_pagerduty is true."
  type        = string
  default     = null
  nullable    = true
}