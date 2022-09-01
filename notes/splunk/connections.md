# Connections Related searches
## Display dates and first and last

```splunk
index=zeek_conn id.resp_h IN(192.168.1.2, 10.10.10.1) conn_state=SF 
| stats min(_time) as "First Communication" max(_time) as "Latest Communication" count(id.resp_h) AS "Total Connections" by id.orig_h
| convert ctime("First Communication") 
| convert ctime("Latest Communication") 
| table id.orig_h "First Communication" "Latest Communication" "Total Connections"
| rename id.orig_h AS "Host"
| sort "First Communication"
```