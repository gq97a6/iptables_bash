# IPv6 rules
ip6tables -F
ip6tables -X

#Set policy
ip6tables -P INPUT DROP
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD DROP

#Group rules into chains
ip6tables -N _INPUT
ip6tables -N _OUTPUT
ip6tables -N _FORWARD

#Append chains
ip6tables -A INPUT -j _INPUT
ip6tables -A OUTPUT -j _OUTPUT
ip6tables -A FORWARD -j _FORWARD

#Allow related and established
ip6tables -A _INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
ip6tables -A _FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#Allow loopback
ip6tables -A _INPUT -i lo -j ACCEPT

#Allow ICMPv6 (required)
ip6tables -A _INPUT -p icmpv6 -j ACCEPT

#Allow nebula
ip6tables -A _INPUT -p tcp --dport 4242 -j ACCEPT
ip6tables -A _INPUT -p udp --dport 4242 -j ACCEPT

ip6tables-save > /etc/iptables/rules.v6
