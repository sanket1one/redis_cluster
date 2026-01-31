#!/bin/bash

echo "Stopping Redis Cluster nodes..."

for i in {1..6}; do
    PID_FILE=./redis-$i/redis.pid

    if [ -f $PID_FILE ]; then
        PID=$(cat $PID_FILE)
        echo "Stopping Redis on port redis-$i (PID: $PID)..."
        kill $PID
    else
        echo "Redis on port redis-$i is not running."
    fi
done

echo "All Nodes stopped"
echo "Checking running processes..."
ps aux | grep redis-server | grep -v grep