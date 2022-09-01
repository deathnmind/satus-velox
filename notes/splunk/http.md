# HTTP related searches

## Find HTTP requests to host with IP Address instead of name
Change `uri=` to include a search term in the URI. ***lookup asnserver*** is a custom script for ASN information.
```splunk
index=zeek_http NOT id.resp_h IN(10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 172.110.88.0/24) uri="*min.js*"
| where isnotnull(uri)
| spath host
| where match(host, "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")
| stats count by host
| lookup asnserver ip as host
| table host as_country_code as_description as_number count
| sort as_description
```