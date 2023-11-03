
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Redis Cache Invalidation Incident.
---

Redis Cache Invalidation Incident refers to the situation where the Redis cache which is a key-value data store, fails to invalidate or remove data that has been modified or deleted in the primary data store. This can lead to inconsistencies and errors in the application that relies on the cache for faster data retrieval. The incident requires the identification of the root cause and the implementation of a solution to ensure that the cache stays in sync with the primary data store.

### Parameters
```shell
export CACHE_EXPIRATION_TIME_IN_SECONDS="PLACEHOLDER"

export PATH_TO_REDIS_CONFIG_FILE="PLACEHOLDER"

export CACHE_EVICTION_POLICY="PLACEHOLDER"
```

## Debug

### Check Redis server is running
```shell
systemctl status redis-server
```

### Check connection to Redis server
```shell
redis-cli ping
```

### Check Redis keys
```shell
redis-cli keys *
```

### Check Redis cache size
```shell
redis-cli info | grep used_memory_human
```

### Check last time Redis cache was saved
```shell
redis-cli lastsave
```

### Check Redis cache memory usage
```shell
redis-cli info memory
```

### Check Redis cache AOF (Append Only File) size
```shell
redis-cli info persistence | grep aof
```

### Check Redis cache RDB (Redis Database File) size
```shell
redis-cli info persistence | grep rdb
```

## Repair

### Review the Redis cache configuration settings to ensure that it is set up for proper data expiration and eviction policies that match the data access patterns of the application.
```shell


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


```