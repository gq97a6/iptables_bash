echo "RAW PREROUTING ====================="
iptables -t raw -S PREROUTING
echo "RAW OUTPUT ========================="
iptables -t raw -S OUTPUT
echo "MANGLE INPUT ======================="
iptables -t mangle -S INPUT
echo "MANGLE OUTPUT ======================"
iptables -t mangle -S OUTPUT
echo "MANGLE FORWARD ====================="
iptables -t mangle -S FORWARD
echo "MANGLE PREROUTING =================="
iptables -t mangle -S PREROUTING
echo "MANGLE POSTROUTING ================="
iptables -t mangle -S POSTROUTING
echo "NAT PREROUTING ====================="
iptables -t nat -S PREROUTING
echo "NAT POSTROUTING ===================="
iptables -t nat -S POSTROUTING
echo "NAT OUTPUT ========================="
iptables -t nat -S OUTPUT
echo "FILTER INPUT ======================="
iptables -t filter -S INPUT
echo "FILTER OUTPUT ======================"
iptables -t filter -S OUTPUT
echo "FILTER FORWARD ====================="
iptables -t filter -S FORWARD


