#!/bin/sh
sudo vconfig rem eth0.4
sudo vconfig rem eth0.6
sudo vconfig rem eth0.7
sudo killall pppoe-server
sudo service isc-dhcp-server stop
sudo vconfig add eth0 4
sudo vconfig add eth0 6
sudo vconfig add eth0 7
sudo pppoe-server -I eth0.4
sudo ifconfig eth0.6 192.168.99.1 netmask 255.255.255.0
sudo ifconfig eth0.6 up
sudo ifconfig eth0.7 192.168.98.200 netmask 255.255.255.0
sudo ifconfig eth0.7 up
sudo service isc-dhcp-server start
