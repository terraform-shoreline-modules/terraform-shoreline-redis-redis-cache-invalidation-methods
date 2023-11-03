resource "shoreline_notebook" "redis_cache_invalidation_incident" {
  name       = "redis_cache_invalidation_incident"
  data       = file("${path.module}/data/redis_cache_invalidation_incident.json")
  depends_on = [shoreline_action.invoke_update_redis_cache_config]
}

resource "shoreline_file" "update_redis_cache_config" {
  name             = "update_redis_cache_config"
  input_file       = "${path.module}/data/update_redis_cache_config.sh"
  md5              = filemd5("${path.module}/data/update_redis_cache_config.sh")
  description      = "Review the Redis cache configuration settings to ensure that it is set up for proper data expiration and eviction policies that match the data access patterns of the application."
  destination_path = "/tmp/update_redis_cache_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_redis_cache_config" {
  name        = "invoke_update_redis_cache_config"
  description = "Review the Redis cache configuration settings to ensure that it is set up for proper data expiration and eviction policies that match the data access patterns of the application."
  command     = "`chmod +x /tmp/update_redis_cache_config.sh && /tmp/update_redis_cache_config.sh`"
  params      = ["CACHE_EXPIRATION_TIME_IN_SECONDS","CACHE_EVICTION_POLICY","PATH_TO_REDIS_CONFIG_FILE"]
  file_deps   = ["update_redis_cache_config"]
  enabled     = true
  depends_on  = [shoreline_file.update_redis_cache_config]
}

