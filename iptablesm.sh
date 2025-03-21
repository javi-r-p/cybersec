#!/bin/bash
clear

# Rules managing for IPTables

# Colours definition
nocolour='\e[0m'                #Delete colour
boldyellow='\033[1;33m'         #Bold yellow
boldcyan='\033[1;36m'           #Bold cyan
yellow='\033[0;93m'             #Bright yellow
red='\033[0;91m'                #Bright red
green='\033[0;92m'              #Bright green
blue='\033[0;94m'               #Bright blue
cyan='\033[0;96m'               #Bright cyan
brightboldcyan='\033[1;96m'     #Bold and bright cyan
backred='\033[0;101m'           #Bright red background

# Welcome message
echo -e "${green}IPTables rules manager${nocolour}"
echo -e "${red}Please note that if you use any domain name, the device must be able to resolve them.${nocolour}"
sleep 2

# Error control and exit function
function quit() {
    if [ $1 -eq 0 ]; then
        echo -e "${green}Program has ended with code $1${nocolour}"
        exit $1
    else
        echo -e "${red}Programa has ended with code $1${nocolour}"
        exit $1
    fi
}

# Check the running user is root
if [ $EUID -ne 0 ]; then
    echo "You must be root to run this script"
    quit 1
fi

# Function to add a rule
function add() {
    echo -e "${green}-----${nocolour}"
    echo "Add a rule"
    if [ $1 -eq 1 ]; then
        echo "The rule will be added to the filter table"
        read -p "Select a chain to which add the rule: (INPUT / OUTPUT / FORWARD) " chain
        echo "-----"
        case $chain in
            "INPUT")
                read -p "Interface through which the packet is received: " i
            "OUTPUT")
                read -p "Interface through which the packet is sent: "
                read -p "Destination address or domain name: " d
            "FORWARD")
                read -p "Interface through which the packet is sent: "
                read -p "Interface through which the packet is received: " i
                read -p "Destination address or domain name: " d
            *)
                echo "The chain you have chosen doesn't exist"
                quit 1
            esac
            read -p "Source IP address or domain name: " s
            read -p "Protocol: " p
            if [ -n $p ]; then
                read -p "Destination port: " dport
                read -p "Source port: " sport
            fi
        fi
    else
        echo "The rule will be added to the NAT table"
    fi
}

# Function to view rules
function list() {
    echo -e "${blue}-----${nocolour}"
    if [ $1 -eq 1 ]; then
        echo "Showing NAT table rules"
        iptables -t nat -L -n
    elif [ $1 -eq 2 ]; then
        echo "Showing filter table rules"
        iptables -t filter -L -n
    elif [ $1 -eq 3 ]; then
        echo "Showing rules for all tables"
        iptables -L
    fi
}

# Function to delete a rule
function delete {
    echo -e "${backred}Delete a rule${nocolour}"
}

# Menu
echo "-----"
echo "Available options:"
echo -e "${green}1. Add a rule${nocolour}"
echo -e "${blue}2. View rules${nocolour}"
echo -e "${backred}3. Delete a rule${nocolour}"
echo -e "${yellow}4. Exit${nocolour}"
read -p "Choose an action: " option
case $option in
    1)
        echo "You can add a rule in these two tables:"
        echo "1. Filter (firewall)"
        echo "2. NAT"
        read -p "Choose a table: " table
        while
            read -p "Choose a table: " table
            [ -z $table ] || [ $table -gt 3 ] || [ $table -lt 1 ]
        do
            echo -e "${backred}The table you have chosen doesn't exist${nocolour}"
        done
        add $table;;
    2)
        echo "You can view the rules in these three tables:";
        echo "1. Filter (firewall)"
        echo "2. NAT"
        echo "3. All tables"
        while
            read -p "Choose a table: " table
            [ -z $table ] || [ $table -gt 3 ] || [ $table -lt 1 ]
        do
            echo -e "${backred}The table you have chosen doesn't exist${nocolour}"
        done
        list $table;;
    3)
        delete;;
    4)
        quit 0;;
esac
