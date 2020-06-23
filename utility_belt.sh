#!/bin/bash


# Title: utility_belt.sh
#
# Description: The purpose of this bash script is to install common troubleshooting tools. 
#              I have compiled a list of tools I have been using to troubleshoot customer issues below.
#
# Tools - bwm-ng, bind-utils, tcpdump, netstat, ss, netcat, whois, traceroute, mtr, vmstat, iostat, sysstat, syslog, nmap, smokeping
#
# Tools list subject to change as platforms start implementing them by default on base images for cloud platforms.


# Greet the user
echo "Greetings, we will be installing common network troubleshooting and system logging tools on the system."
sleep 2s

if [ $1 = "redhat" ]
then
	redhat_tools="bind bind-utils dropwatch nmap traceroute mtr nc ss vmstat iostat sysstat whois tcpdump smokeping"
	echo "This is redhat based OS, the yum package management tool will be used to install the packages.."
	sleep 5s
	sudo yum install -y $redhat_tools
elif [ $1 = "debian" ]
then
	debian_tools="sysstat bwm-ng whois smokeping"
	echo "This is debian based OS, the apt package management tool will be used to install the packages.."
	sleep 3s
	sudo apt-get install -y $debian_tools
fi
