#!/bin/sh
#
# Author : Joba Yang
# Date   : 2013/07/08
# Email  : donychopper@gmail.com
#

#
# Clean all visual interface and routing WAN service
#

testing=$(ifconfig | grep eth0.4)
if [ "$testing" != "" ]; then
	sudo vconfig rem eth0.4
fi
testing=$(ifconfig | grep eth0.6)
if [ "$testing" != "" ]; then
	sudo vconfig rem eth0.6
fi
testing=$(ifconfig | grep eth0.7)
if [ "$testing" != "" ]; then
	sudo vconfig rem eth0.7
fi
PoeServer=$(ps ax | grep pppoe-server | grep eth0.4)
if [ "$PoeServer" != "" ]; then
	sudo killall pppoe-server
fi
DhcpServer=$(sudo service isc-dhcp-server status | grep running)
if [ "$DhcpServer" != "" ]; then
	sudo service isc-dhcp-server stop
fi

# 
# Setup up all visual interface and routing WAN service
# 

sudo vconfig add eth0 4
sudo vconfig add eth0 6
sudo vconfig add eth0 7
sudo pppoe-server -I eth0.4
sudo ifconfig eth0.6 192.168.99.1 netmask 255.255.255.0
sudo ifconfig eth0.6 up
sudo ifconfig eth0.7 192.168.98.200 netmask 255.255.255.0
sudo ifconfig eth0.7 up
sudo service isc-dhcp-server start
