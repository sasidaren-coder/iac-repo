variable "environment_name" {
  description = "Name of the Confluent Cloud environment."
  type        = string

  validation {
    condition     = length(trimspace(var.environment_name)) >= 4 && length(var.environment_name) <= 50
    error_message = "The environment name must be between 4 and 50 characters long."
  }
}

variable "stream_governance_package" {
  description = "Stream Governance package to enable in the environment. Valid values: 'ESSENTIAL', 'ADVANCED'"
  type        = string
  default     = "NONE"

  validation {
    condition     = contains(["ESSENTIALS", "ADVANCED"], upper(var.stream_governance_package))
    error_message = "Invalid value for stream_governance_package. Allowed values are: 'ESSENTIAL', 'ADVANCED'"
  }
}
