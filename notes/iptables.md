# IPTables Commands

```bash
sudo iptables -F
sudo iptables -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp -s 172.19.0.225 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -o eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i lo -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -o lo -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -P FORWARD DROP
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
clear && sudo iptables -L -v
```

## flush

```bash
sudo iptables -F
```

## input and output established,related

```bash
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

## accept only remote source IP 172.19.0.225 to access local SSH server

```bash
sudo iptables -A INPUT -i eth0 -p tcp -s 172.19.0.255 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
```

## accept all output traffic with destination port 80

```bash
sudo iptables -A OUTPUT -o eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A INPUT -i eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
```

## applied to lo interface accept all traffic

```bash
sudo iptables -A INPUT -i lo -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -i lo -m state --state ESTABLISHED,RELATED -j ACCEPT
```

```bash
sudo iptables -A INPUT -i eth0 -p tcp -s 172.19.0.0/16 -m multiport --dports 21,80 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A INPUT -i eth0 -p tcp -s 172.19.0.0/16 --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
```

## default policies to drop

```bash
sudo iptables -P FORWARD DROP
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
```

```bash
sudo iptables -N LOGGING
sudo iptables -A INPUT -j LOGGING
sudo iptables -A LOGGING -j DROP
```

172.19.0.9

1. Set the default policies to DROP for the INPUT, FORWARD, and OUTPUT chains.
2. Create a rule to ACCEPT all connections that are ESTABLISHED,RELATED on the INPUT and the OUTPUT chains.
3. Create a rule to ACCEPT only remote source IP address 172.19.0.225 to access the local SSH server (on port 22).
4. Create a rule to ACCEPT any source IP to the local TCP services on ports 21 and 80.
5. Create a rule to ACCEPT all OUTPUT traffic with a destination TCP port of 80.
6. Create a rule applied to the INPUT chain to ACCEPT all traffic from the lo interface.
