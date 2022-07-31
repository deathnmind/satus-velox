# Certificate related searches

## Let's Encrypt
### Let's Encrypt certicates for a specific domain of interest
Can change domain in the certifcate search. This search help to highlight DNS queries for a domain that maybe shouldn't be using a Let's Encrypt Certificate. ***Requires UT_Toolbox*** -- ***lookup asnserver*** is a custom script for ASN information.
```splunk
index=zeek_dns OR index=extra_zeek_dns 
    [ search index=zeek_x509 certificate.issuer="*Let's Encrypt*" san.dns{} IN("*.example.com") 
    | dedup certificate.serial 
    | stats count by san.dns{} 
    | rename san.dns{} as query 
    | eval list="mozilla" 
    | eval Type="Domain" 
    | `ut_parse_extended(query,list)` 
    | stats count by query ut_domain 
    | strcat "*." ut_domain new_domain 
    | table new_domain 
    | rename new_domain as query ] 
| stats count by query answers 
| lookup asnserver ip as answers
```

## Finding certificate with a recent validity date
Finding certificates newer than 7 days
```splunk
index=zeek_x509 
| dedup certificate.serial 
| rex "O=(?<Org>[^,]+)" 
| eval Org= mvindex(split(mvindex(split(Org,","),0),"\\"),0) 
| rex field=_raw \"certificate.not_valid_after\":(?P<not_after>\d+) | eval read_not_after=strftime(not_after, "%Y-%m-%dT%H:%M:%S")
| rex field=_raw \"certificate.not_valid_before\":(?P<not_before>\d+) | eval read_not_before=strftime(not_before, "%Y-%m-%dT%H:%M:%S")
| rename not_after as expiry not_before as issue 
| eval c_time = now() 
| eval days = round((c_time - issue)/86400,0) 
| search days<7 
| convert ctime(issue) 
| table _time san.dns{} read_not_before read_not_after days certificate.serial certificate.issuer Org
| sort days
```

## A Join that works
```splunk
index=zeek_conn conn_state=SF 
| join type=inner uid 
    [| search index=zeek_ssl issuer="CN=E1,O=Let's Encrypt,C=US" 
    | table uid,server_name, issuer] 
| lookup asnserver ip as id.resp_h 
| stats count by id.orig_h id.resp_h server_name issuer as_description
```