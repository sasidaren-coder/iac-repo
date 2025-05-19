inputs = {
  confluent_api_key    = get_env("CONFLUENT_API_KEY")
  confluent_api_secret = get_env("CONFLUENT_API_SECRET")
  kafka_api_key        = get_env("KAFKA_API_KEY")
  kafka_api_secret     = get_env("KAFKA_API_SECRET")
  kafka_cluster_id     = get_env("KAFKA_CLUSTER_ID")
  kafka_rest_endpoint  = get_env("KAFKA_REST_ENDPOINT")
}