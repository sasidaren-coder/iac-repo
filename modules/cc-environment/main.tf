resource "confluent_environment" "this" {
  display_name = var.environment_name

  stream_governance {
    package = var.stream_governance_package
  }


  # lifecycle {
  #   prevent_destroy = true
  # }

}