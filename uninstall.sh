#!/bin/sh

sudo service mysqld stop
sudo yum -y erase git
sudo yum -y erase java-1.6.0-openjdk-devel
sudo yum -y erase mysql
sudo yum -y erase mysql-server
sudo yum -y erase ant

cd
rm -rf tagbrowser
rm -rf mysql*
rm -rf seam.zip
rm -rf jboss*
rm -rf log
rm install.sh
rm uninstall.sh
sudo rm -rf /srv/*

reboot

