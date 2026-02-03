*** REDIS CLUSTER ***

*** Redis Sentinel ***
Ensures the system remains operational even when individual Redis instances fail.

### Key Capabilities:
- **Monitoring**: Constantly checks if master and replicas are working.
- **Notification**: Alerts other applications/scripts via API about problems.
- **Automatic Failover**: Promotes a replica to master if the master fails.
- **Configuration Provider**: Acts as a source of truth for clients to find the current master.

### Architecture in this Repo:
Located in `./sentinel-setup`:
- **1 Master**: The primary node for writes.
- **2 Replicas**: Secondary nodes that sync data from the master.
- **3 Sentinels**: Independent processes that monitor nodes and handle failover.

### How to Run:
```bash
cd sentinel-setup
docker-compose up -d
```

### Testing Automatic Failover:
1. **Watch Logs**: `docker logs -f redis-sentinel-1`
2. **Crash the Master**: `docker stop redis-master`
3. **Observation**: After ~5 seconds, Sentinels will detect the failure and promote a replica.
4. **Verify New Master**: 
   ```bash
   docker exec -it redis-sentinel-1 redis-cli -p 26379 sentinel get-master-addr-by-name mymaster
   ```

### Useful Commands:
- **Check Master Info**: `redis-cli -p 26379 sentinel master mymaster`
- **Check Replicas**: `redis-cli -p 26379 sentinel replicas mymaster`
- **Check Sentinel Peers**: `redis-cli -p 26379 sentinel sentinels mymaster`


