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

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}