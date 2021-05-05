#!/bin/bash

# System diagnostics tooling user data script.
#
# Installs epel repository, atop, iotop, htop, iftop, nc, arpwatch on Amazon Linux 2 AMI based EC2 instances.
#
# Script can be copied and placed into the User data field when launching an EC2 instance.
# Note this should be run as user data just once and removed from user data once the instance
# has been launched.
#
# Note: if running from command line, be sure to add execute function and add sudo before executing 
# the bash script:
# 
# $ chmod +x system_mon_tool.sh
# $ sudo ./system_mon_tool.sh

amazon-linux-extras install epel

yum install -y atop iotop htop iftop nmap-ncat arpwatch
