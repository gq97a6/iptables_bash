echo "RAW PREROUTING ====================="
ip6tables -t raw -S PREROUTING
echo "RAW OUTPUT ========================="
ip6tables -t raw -S OUTPUT
echo "MANGLE INPUT ======================="
ip6tables -t mangle -S INPUT
echo "MANGLE OUTPUT ======================"
ip6tables -t mangle -S OUTPUT
echo "MANGLE FORWARD ====================="
ip6tables -t mangle -S FORWARD
echo "MANGLE PREROUTING =================="
ip6tables -t mangle -S PREROUTING
echo "MANGLE POSTROUTING ================="
ip6tables -t mangle -S POSTROUTING
echo "NAT INPUT ========================="
ip6tables -t nat -S INPUT
echo "NAT OUTPUT ========================="
ip6tables -t nat -S OUTPUT
echo "NAT PREROUTING ====================="
ip6tables -t nat -S PREROUTING
echo "NAT POSTROUTING ===================="
ip6tables -t nat -S POSTROUTING
echo "FILTER INPUT ======================="
ip6tables -t filter -S INPUT
echo "FILTER OUTPUT ======================"
ip6tables -t filter -S OUTPUT
echo "FILTER FORWARD ====================="
ip6tables -t filter -S FORWARD
