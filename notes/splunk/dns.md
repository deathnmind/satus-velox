# DNS Related Queries

## Splunk raw.githubusercontent.com query  
Raw Githubusercontent can be getting scripts directly from github and should be reviewed.
```splunk
index=zeek_conn conn_state=SF (id.resp_h=185.199.108.133 OR id.resp_h=185.199.109.133 OR id.resp_h=185.199.110.133 OR id.resp_h=185.199.111.133)
    [ search index=zeek_dns OR index=extra_zeek_dns raw.githubusercontent.com 
    | stats count by id.orig_h 
    | search count < 10 
    | fields - count ] 
| eval orig_mbytes=round(orig_bytes/1024/1024,2) 
| eval resp_mbytes=round(resp_bytes/1024/1024,2) 
| eval mbytes=sum(orig_mbytes + resp_mbytes) 
| eval mbytes=round(mbytes,2) 
| stats values(transport) as transport sum(mbytes) as MB by id.orig_h id.resp_h 
| sort - MB
```