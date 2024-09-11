#!/bin/bash
# Update the system packages
sudo yum update -y

# Install Apache HTTP Server
sudo yum install -y httpd

# Capture hostname and IP address and write to the index.html file
echo "This is $(hostname) and the IP is $(hostname -I)" > /var/www/html/index.html

# Enable and start Apache HTTP Server
sudo systemctl enable httpd
sudo systemctl start httpd
