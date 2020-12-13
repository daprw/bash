#!/bin/bash

# bash script that installs AWS Systems Manager on CentOS 7.
# going to optimize this later to be able to run any linux system

# install SSM Agent on CentOS 7
sudo yum install -y https://s3.region.amazonaws.com/amazon-ssm-region/latest/linux_amd64/amazon-ssm-agent.rpm

# install SSM Agent on CentOS 8
# sudo dnf install -y https://s3.region.amazonaws.com/amazon-ssm-region/latest/linux_amd64/amazon-ssm-agent.rpm

# check if SSM Agent is running
sudo systemctl status amazon-ssm-agent

# enable SSM Agent to start on boot
sudo systemctl enable amazon-ssm-agent

# start SSM Agent service
sudo systemctl start amazon-ssm-agent

# check status of SSM Agent
sudo systemctl status amazon-ssm-agent
