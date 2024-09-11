#!bin/bash
sudo yum update -y
sudo yum install httpd -y 
echo "This is $(hostname) and the ip is $(hostname -i)"> /var/wwww/html/index.html
systemctl enable http 
systemctl start http 
