#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# install git
sudo apt-get install git -y

# install nodejs
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

sudo npm install pm2 -g

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y
sudo apt-get install mongodb-org=3.2.20 -y
sudo systemctl start mongod
# Systemd provides a standard process for controlling what programs run when a Linux system boots up.
# systemd gives us the systemctl command which is mostly used to enable services to start at boot time.
sudo systemctl enable mongod
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
# gets into that file, replace 01 by 0, to comply with the tests., which port to look
sudo systemctl restart mongod.service
