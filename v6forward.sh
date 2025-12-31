#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

add_forwarding() {
    echo -e "${BLUE}=== Add IPv6 Forwarding ===${NC}"
    read -p "Enter internal IPv6 address: " internal_ip
    read -p "Enter port number: " port

    [[ $internal_ip != *:* ]] && { echo -e "${RED}Invalid IPv6${NC}"; return 1; }
    [[ ! $port =~ ^[0-9]+$ || $port -lt 1 || $port -gt 65535 ]] && { echo -e "${RED}Invalid port${NC}"; return 1; }

    if ip6tables -C FORWARD -p tcp -d $internal_ip --dport $port -j ACCEPT 2>/dev/null; then
        echo -e "${YELLOW}Rule exists. Replace? (y/n)${NC}"
        read replace
        [[ $replace != "y" ]] && return 1
        remove_forwarding_silent $port
    fi

    ip6tables -A FORWARD -p tcp -d $internal_ip --dport $port -j ACCEPT
    ip6tables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT 2>/dev/null

    echo -e "${GREEN}✓ IPv6 forwarding added: port $port → $internal_ip${NC}"
}

remove_forwarding_silent() {
    local port=$1
    while ip6tables -L FORWARD -n --line-numbers | grep -q "dpt:$port"; do
        line=$(ip6tables -L FORWARD -n --line-numbers | grep "dpt:$port" | head -1 | awk '{print $1}')
        ip6tables -D FORWARD $line 2>/dev/null
    done
}

remove_forwarding() {
    echo -e "${BLUE}=== Remove IPv6 Forwarding ===${NC}"
    list_forwarding
    read -p "Enter port to remove: " port

    [[ ! $port =~ ^[0-9]+$ || $port -lt 1 || $port -gt 65535 ]] && { echo -e "${RED}Invalid port${NC}"; return 1; }
    ! ip6tables -L FORWARD -n | grep -q "dpt:$port" && { echo -e "${RED}Rule not found${NC}"; return 1; }

    remove_forwarding_silent $port
    echo -e "${GREEN}✓ Removed${NC}"
}

list_forwarding() {
    echo -e "${BLUE}=== Current IPv6 Forwarding ===${NC}"
    ip6tables -L FORWARD -n | grep dpt: || echo -e "${YELLOW}None${NC}"
}

show_detailed() {
    echo -e "${BLUE}=== Detailed ip6tables ===${NC}"
    ip6tables -L FORWARD -n -v --line-numbers
}

main_menu() {
    while true; do
        echo -e "\n${BLUE}══════ IPv6 Port Forwarding ══════${NC}\n"
        echo "1) Add forwarding"
        echo "2) Remove forwarding"
        echo "3) List rules"
        echo "4) Show detailed"
        echo "5) Exit"
        read -p "Select [1-5]: " choice

        case $choice in
            1) add_forwarding ;;
            2) remove_forwarding ;;
            3) list_forwarding ;;
            4) show_detailed ;;
            5) exit 0 ;;
            *) echo -e "${RED}Invalid${NC}" ;;
        esac
        read -p "Enter to continue..."
    done
}

[[ $EUID -ne 0 ]] && { echo -e "${RED}Run as root${NC}"; exit 1; }
sysctl -qw net.ipv6.conf.all.forwarding=1
main_menu
