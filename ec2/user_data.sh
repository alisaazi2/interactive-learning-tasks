#!/bin/bash
sudo yum install httpd -y
sudo echo $HOSTNAME >> /var/www/html/index.html
sudo systemctl start httpd
