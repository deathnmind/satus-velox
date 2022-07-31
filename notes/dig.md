# DIG

**Step1 find domain FQDN**</br>
**Reverse DNS - resolver.domain should be the DNS server to query**</br>
`dig @resolver.domain -x {IP_Address} +short`

**Step2 get the SOA Records**</br>
**Query for SOA Records - local.domain should be the domain name found from reverse lookup**</br>
`dig @resolver.domain local.domain SOA`

**Query ALL DNS Records - resolver.domain should be the DNS server to query**</br>
`dig @resolver.domain ANY +noall +answer`

**Query TTL Records**</br>
`dig @resolver.domain local.domain TTL`

**Query MX Records**</br>
`dig @resolver.domain local.domain MX`

**Query Domain "A" Records with +short**</br>
`dig @resolver.domain local.domain +short`

**Test zone transfer**</br>
`dig @resolver.domain AXFR zonetransfer.domain`
