#!/bin/bash

echo "Starting Redis Cluster nodes..."



for i in {1..6}; do
    echo "Start node on port redis-$i..."
    cd ./redis-$i

    # Start the server suing the. local confg file
    redis-server redis.conf

    cd ..
done

echo "All Nodes started"
echo "Checking running processes..."

ps aux | grep redis-server | grep -v grep