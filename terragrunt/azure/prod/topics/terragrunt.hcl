include {
  path = find_in_parent_folders("_common/common.hcl")
}

locals {
  cloud_provider = get_env("CLOUD_PROVIDER", "azure")
  env            = get_env("ENV", "dev")
  topic_path     = "${get_terragrunt_dir()}/${get_env("FILE_NAME")}"
  

  # Parse topic name from YAML (assumes only one topic)
  topic_config_raw = yamldecode(file(local.topic_path))
  topic_name       = local.topic_config_raw.topic.name

  # Extract Pipeline version
  iac_version    = local.topic_config_raw.pipeline_version
}

terraform {
  source = "git::https://github.com/sasidaren-coder/iac-repo.git//modules/kafka-topics?ref=v${local.iac_version}"
}

inputs = {
# From common.hcl    
#   confluent_api_key    = get_env("CONFLUENT_API_KEY")
#   confluent_api_secret = get_env("CONFLUENT_API_SECRET")
#   kafka_api_key        = get_env("KAFKA_API_KEY")
#   kafka_api_secret     = get_env("KAFKA_API_SECRET")
#   kafka_cluster_id     = get_env("KAFKA_CLUSTER_ID")
#   kafka_rest_endpoint  = get_env("KAFKA_REST_ENDPOINT")
  topic_path           = local.topic_path
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "confluent" {
  cloud_api_key    = var.confluent_api_key
  cloud_api_secret = var.confluent_api_secret
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "${get_env("AZURE_RESOURCE_GROUP_NAME", "psy-flink-poc")}"
    storage_account_name = "${get_env("AZURE_STORAGE_ACCOUNT_NAME", "psyflinkops")}"
    container_name       = "${get_env("AZURE_STORAGE_CONTAINER_NAME", "psyflinkcontainer")}"
    key                  = "${local.env}/${local.iac_version}/topics/${local.topic_name}.tfstate"
  }
}
EOF
}
