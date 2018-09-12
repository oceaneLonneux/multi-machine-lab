#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Update the sources list
sudo apt-get update -y
# upgrade any packages available
sudo apt-get upgrade -y

sudo apt-get install mongodb-org=3.2.20 -y

sudo rm /etc/mongod.conf
sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongo.conf

# Systemd provides a standard process for controlling what programs run when a Linux system boots up.
# systemd gives us the systemctl command which is mostly used to enable services to start at boot time.
sudo systemctl restart mongod.service
sudo systemctl enable mongod
