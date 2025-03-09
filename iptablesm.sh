#!/bin/bash
clear

# Rules managing for IPTables
echo "IPTables rules manager"

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

# Error control and exit function
function quit() {
    code=$1
    if [ $code -eq 0 ]; then
        echo -e "${green}Program has ended with code $code${nocolour}";
        exit $code;
    else
        echo -e "${red}Programa has ended with code $code${nocolour}";
        exit $code;
    fi
}

# Check the running user is root
if [ $EUID -ne 0 ]; then
    echo "You must be root to run this script";
    quit 1;
fi

# Function to add a rule
function add() {
    table=$1;
    echo -e "${green}Add a rule${nocolour}";
    if [ $table -eq 1 ]; then
        echo "The rule will be added to the filter table";
        read -p "Select a chain to which add the rule: (INPUT / OUTPUT / FORWARD) " chain;
        if [ $chain == "INPUT" ]; then
            echo "The rule will be added to the INPUT chain";
        elif [ $chain == "OUTPUT" ]; then
            echo "The rule will be added to the OUTPUT chain";
        elif [ $chain == "FORWARD" ]; then
            echo "The rule will be added to the FORWARD chain";
        else
            echo "The chain you have chosen doesn't exist";
            quit 1;
        fi
    else
        echo "The rule will be added to the NAT table";
    fi
}

# Function to view rules
function list() {
    table=$1;
    if [ $table -eq 1 ]; then
        echo "Showing NAT table rules"
        iptables -t nat -L -n
    elif [ $table -eq 2 ]; then
        echo "Showing filter table rules"
        iptables -t filter -L -n
    elif [ $table -eq 3 ]; then
        echo "Showing rules for all tables"
        iptables -L
    fi
}

# Function to delete a rule
function delete {
    echo -e "${backred}Delete a rule${nocolour}";
}

# Menu
echo "-----";
echo "Available options:";
echo -e "${green}1. Add a rule${nocolour}";
echo -e "${blue}2. View rules${nocolour}";
echo -e "${backred}3. Delete a rule${nocolour}";
echo -e "${yellow}4. Exit${nocolour}";
read -p "Choose an action: " option;
case $option in
    1)
        echo "You can add a rule in these two tables:";
        echo "1. Filter (firewall)";
        echo "2. NAT";
        read -p "Choose a table: " table;
        if [ -z $table || $table -ne 1 || $table -ne 2 ]; then
            echo "The table you have chosen doesn't exist";
            quit 1;
        fi
            add $table;;
    2)
        echo "You can view the rules in these two tables:";
        echo "1. Filter (firewall)";
        echo "2. NAT";
        read -p "Choose a table: " table;
        if [ -z $table || $table -ne 1 || $table -ne 2 ]; then
            echo "The table you have chosen doesn't exist";
            quit 1;
        fi
        list $table;;
    3)
        delete;;
    4)
        quit 0;;
esac