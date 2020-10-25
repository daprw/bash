#!/bin/bash

# Rudimentary bash shell script that installs basic apache web server
# on AWS EC2 instance running Amazon Linux 2 AMI. Can be used in user
# data scripts as well for testing purposes. 

yum update -y 
yum install -y httpd
systemctl start httpd
systemctl enable httpd
cd /var/www/html
echo "<html><body><h1>A Basic Website</h1></body></html>" > index.html
