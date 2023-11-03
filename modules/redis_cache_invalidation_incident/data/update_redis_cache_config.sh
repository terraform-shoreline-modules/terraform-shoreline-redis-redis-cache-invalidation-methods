

#!/bin/bash



REDIS_CONFIG_FILE=${PATH_TO_REDIS_CONFIG_FILE}

REDIS_CACHE_EXPIRATION=${CACHE_EXPIRATION_TIME_IN_SECONDS}

REDIS_CACHE_EVICTION_POLICY=${CACHE_EVICTION_POLICY}



# Check if Redis config file exists

if [[ ! -f $REDIS_CONFIG_FILE ]]; then

  echo "Redis config file not found: $REDIS_CONFIG_FILE"

  exit 1

fi



# Update Redis cache expiration time and eviction policy

sed -i "s/^# *maxmemory-policy.*/maxmemory-policy $REDIS_CACHE_EVICTION_POLICY/g" $REDIS_CONFIG_FILE

sed -i "s/^# *expire.*/expire $REDIS_CACHE_EXPIRATION/g" $REDIS_CONFIG_FILE



# Restart Redis service

systemctl restart redis



echo "Redis cache configuration updated successfully"