#!/bin/bash

START_PORT=7001
END_PORT=7006

# Loop from 7001 to 7006
for PORT in $(seq $START_PORT $END_PORT); do
    echo "Generating config for port $PORT..."
    
    mkdir -p "redis-$PORT"

    cat << EOF > "./redis-$PORT/redis.conf"
port $PORT
protected-mode no
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 127.0.0.1
cluster-announce-port $PORT
cluster-announce-bus-port $(($PORT + 1000))
appendonly yes

# Daemonization and working dir setting
daemonize yes
pidfile ./redis.pid
logfile ./redis.log
dir ./
EOF
done

echo " Success ! Configuration files generated for ports $START_PORT to $END_PORT"