#!/bin/bash

# Run script commands below this line, and tee the output to both stdout and the log file
{

    if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run as root."
        exit 1
    fi

    # Check if iptables is installed and list rules if it is
    echo "Checking for iptables..."
    if command -v iptables >/dev/null 2>&1; then
        echo "iptables is installed. Here are the current iptables rules:"
        sudo iptables -L
    else
        echo "iptables is not installed."
    fi
    echo ""

    # Check if nftables is installed and list rules if it is
    echo "Checking for nftables..."
    if command -v nft >/dev/null 2>&1; then
        echo "nftables is installed. Here are the current nftables rules:"
        sudo nft list ruleset
    else
        echo "nftables is not installed."
    fi
    echo ""

    # Check if ufw is installed and list status if it is
    echo "Checking for ufw (Uncomplicated Firewall)..."
    if command -v ufw >/dev/null 2>&1; then
        echo "ufw is installed. Here is the status of ufw:"
        sudo ufw status
    else
        echo "ufw is not installed."
    fi
    echo ""

    # Check if firewalld is installed and list status if it is
    echo "Checking for firewalld..."
    if command -v firewall-cmd >/dev/null 2>&1; then
        echo "firewalld is installed. Here is the status of firewalld:"
        sudo firewall-cmd --state
        echo "Listing all firewalld zones and their settings:"
        sudo firewall-cmd --list-all-zones
    else
        echo "firewalld is not installed."
    fi
    echo ""

    echo "Firewall check completed."
} 2>&1 | tee /var/log/check-firewall.log