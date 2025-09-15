#!/bin/bash
dnf -y update
dnf -y install httpd
sed -i 's/^Listen 80/Listen 3000/' /etc/httpd/conf/httpd.conf
echo "<h1>web01</h1>" > /var/www/html/index.html
systemctl enable httpd
systemctl start httpd
