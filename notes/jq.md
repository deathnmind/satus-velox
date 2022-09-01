# JQ - to display JSON formatted logs

## Zeek JSON logs

**basic JSON parsing**  
`jq -c '[."id.orig_h", ."query", ."answers"]' dns.log`
