# Security Onion Global

## Zeek Intel.dat Valid Types

- Intel::ADDR
- Intel::SUBNET
- Intel::URL
- Intel::SOFTWARE
- Intel::EMAIL
- Intel::DOMAIN
- Intel::USER_NAME
- Intel::CERT_HASH
- Intel::PUBKEY_HASH
- Intel::FILE_HASH
- Intel::FILE_NAME

## Filtering Snort/Suricata SIDS

### These can be noisey and could be tuned out depending on environment

- 1:2027390 - ET USER_AGENTS Microsoft Device Metadata
- 1:2027758 - ET DNS Query for .co TLD
- 1:2027766 - ET Policy Windows Update P2P
- 1:2012171 - ET Info Dynamic_DNS Query to 3322[.]org
- 1:2101411 - GPL SNMP Public access udp
- 1:2014939 - ET Policy DNS Query for TOR Hidden Domain
- 1:2018959 - ET Policy PE EXE or DLL Windows file download
- 1:2027757 - ET DNS Query for .to TLD
- 1:2027863 - ET INFO Observed DNS Query to .biz TLD
- 1:2028694 - ET Policy DNS Query to DynDNS *.servehttp.com
- 1:2028675 - ET Policy DNS Query to DynDNS *.ddns.net
- 1:2028703 - ET Policy DNS Query to DynDNS *.zapto.org
- 1:2014267 - ET Trojan Query for *.test.3322.org.cn
- 1:2018824 - ET INFO Dynamic_DNS Query *.byinter.net
- 1:2016149 - ET INFO Session Traversal Utilities for NAT (STUN)
- 1:2014920 - ET Policy Microsoft Online Storage (storage.live[.]com)
- 1:2014919 - ET Policy Microsoft Online Storage (storage.msn[.]com)
- 1:2018904 - ET INFO Session Traversal Utilities for NAT (STUN)
- 1:2016150 - ET INFO Session Traversal Utilities for NAT (STUN)
- 1:2013505 - ET Policy GNU/Linux YUM User-Agent Outbound
- 1:2027865 - ET Info DNS Query to .cloud TLD
- 1:2100366 - ET GPL PING *NIX
- 1:2013504 - ET GPL APT User-Agent Outbound
- 1:2022371 - ET p2p MS WUDO Peer Sync

# Security Onion 2 Specific

**Salt update commands**

- Update all members: `salt \* state.highstate`
- Update all sensors: `salt \*_sensor state.highstate`

**Zeek Intel.dat Location:**

- location on manager: `/opt/so/saltstack/local/salt/zeek/policy/intel/intel.dat`  
- location once salt has processed on manager and all minions: `/opt/so/conf/zeek/policy/intel/intel.dat`

**Zeek Packages Location:**

- Custom packages location: `/opt/so/salt/stack/local/salt/zeek/policy/custom`
- Included packages location: `/opt/so/salt/stack/local/salt/zeek/policy/`
- **Adding a custom Zeek package:**
  - mkdir for custom package on manager in `/opt/so/saltstack/local/salt/zeek/policy/custom`
  - copy custom zeek package contents in the created custom folder
  - make sure permissions are correct
  - copy zeek init file from salt deafult to local (never edit the defaults!)
    - default zeek init location: `/opt/so/saltstack/default/pillar/zeek/init.sls`
    - copy to `/opt/so/saltstack/local/pillar/minions/{sensor_name}_sensor.sls`
    - each minion will have its own sls file for initalizing packages
    - remove all the zeekctl: stanzas - just adding a custom packge the default init.sls will load all the default packages
  - at the bottom add the path to the new zeek custom package - for example: `custom/bzar/scripts`
    - the path for the custom package must point to a folder that contains `__load__.zeek` file of the custom package
  - run `so-rule-update` on manager
  - run `salt \*_sensor state.highstate` to update the sensors (the ones with zeek)
  - might have to restart sensor

**File Extraction Configuarion**

- location on manager: `/opt/so/saltstack/default/salt/zeek/fileextraction_default.yml`

**Configure Custom Elasticsearch Settings**

- copy the default elasticsearch.yml into a local folder for editing
  - `cp /opt/so/saltstack/default/salt/elasticsearch/files/elasticsearch.yml /opt/so/saltstack/local/salt/elasticsearch/file/`
- edit the elasticsearch.yml in the local path: `nano /opt/so/saltstack/local/salt/elasticsearch/files/elasticsearch.yml`
- add custom setting to the bottom:
  - `indices.fielddata.cache.size: 20%`
- sync all nodes: `salt \* state.highstate`

**Query Elastic Server from command line**

- `curl -k https://localhost:9200/_stats/fielddata?fields=* | jq`
- The manager Elastic contains information about grid, the Searchnodes contain the sensor data
  - be sure to query the elastic server which actually has the data (ie not the manager but the searchnodes)
- `curl -k GET https://localhost:9200`
- `curl -k -X POST https://localhost:9200`
- Troubleshooting commands vs elastic queries:
  - `so-elasticsearch-indices-list` = `curl -k GET https://localhost:9200/_cat/indices?pretty=true`
  - `so-elasticsearch-shards-list` = `curl -k GET https://localhost:9200/_cat/shards?pretty=true`
  - indexing pressure: `curl -s -k https://localhost:9200/_nodes/stats/indexing_pressure?pretty=true`
  - JVM Properties: `curl -s -k https://localhost:9200/_nodes/stats/jvm?pretty=true`
    - look at `jvm_mem_heap_used_percent`
  - other options under `_nodes/stats`:
    - breaker, discovery, fs, http, indexing_pressure, indices, ingest, jvm, os, process, thread_pool, transport
- UNASSIGNED shards and reason
  - `curl -k -XGET https://localhost:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason | grep UNASSIGNED`
    - more information: `_cluster/allocation/explain>pretty`

**ES_JAVA_OPT**

- Set as environmental variables in so-elasticsearch docker
  - `docker exec -it so-elasticsearch /bin/sh`
  - `printenv` -- show the current ES_JAVA_OPTS
  - `export ES_JAVA_OPTS={paste old ES_JAVA_OPTS string, but change -Xms and -Xmx}` total of both options together should be no more than half the RAM total

**Stenoread - Export PCAP**

- `docker exec -it so-steno stenoread {YOUR BPF FILTER}`
  - output goes to `/nsm/pcaptmp`

**Reset User Passwords:** `sudo so-user update user@fqdn`

**Set disk retension policy per sensor**

- cp `/opt/so/saltstack/default/pillar/minions/{sensor_name}.sls` to the local path `../../../local/pillar/minions`
- edit `/opt/so/saltstack/local/pillar/minions/{sensor_name}.sls`

```yaml
  steno:
    enabled: True
    diskfreepercentage: 60

```
