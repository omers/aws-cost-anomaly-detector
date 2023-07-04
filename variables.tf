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
  type        = list(any)
  description = "List of email addresses to notify"
}

variable "raise_amount_percent" {
  type        = string
  description = "An Expression object used to specify the anomalies that you want to generate alerts for. The precentage service cost increase than the expected"
}

variable "raise_amount_absolute" {
  type        = string
  description = "The Absolut increase in USD to trigger the detector. (ANOMALY_TOTAL_IMPACT_ABSOLUTE)"
}
variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}

variable "create_pagerduty" {
  type        = bool
  default     = false
  description = "Set to true in order to send notifications to PagerDuty"
}

variable "pagerduty_endpoint" {
  description = "The PagerDuty HTTPS endpoint where SNS notifications will be sent to"
  type        = string
}