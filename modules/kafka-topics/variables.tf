variable "confluent_api_key" {
  type        = string
  description = "API key for authenticating with the Confluent Cloud control plane (for provider block)."
  sensitive   = true
}

variable "confluent_api_secret" {
  type        = string
  description = "API secret for the Confluent Cloud control plane (for provider block)."
  sensitive   = true
}

variable "kafka_api_key" {
  type        = string
  description = "Kafka API key for authenticating with the Kafka REST API."
  sensitive   = true
}

variable "kafka_api_secret" {
  type        = string
  description = "Kafka API secret for the Kafka REST API."
  sensitive   = true
}

variable "kafka_cluster_id" {
  type        = string
  description = "The Kafka cluster ID where the topic should be created."
  nullable    = false
  validation {
    condition     = length(var.kafka_cluster_id) > 0
    error_message = "kafka_cluster_id cannot be an empty string."
  }
}

variable "kafka_rest_endpoint" {
  type        = string
  description = "Kafka REST endpoint URL for the target cluster (e.g., https://pkc-xxx.region.confluent.cloud:443)."
  nullable    = false
  validation {
    condition     = can(regex("^https://", var.kafka_rest_endpoint))
    error_message = "kafka_rest_endpoint must be a valid HTTPS URL."
  }
}

variable "topic_path" {
  type        = string
  description = "Absolute path to the YAML file defining the topic configuration (must be a single-topic YAML)."
  nullable    = false
  validation {
    condition     = can(regex("\\.ya?ml$", var.topic_path))
    error_message = "topic_path must point to a .yaml or .yml file."
  }
}
