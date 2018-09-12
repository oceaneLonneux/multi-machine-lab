# Second Lab - Multi Machine Vagrant

## Multi Machine Vagrant
### Timings
120 - 180 Minutes
### Summary
The sample application has the ability to connect to a databse. We need to provision our development environment with a vm for the database and one for the database.
Vagrant is capable of running two or more virtual machines at once with different confiurations.
### Tasks
Research how to create a multi machine vagrant environment
Add a second virtual machine called "db" to your Vagrant file
Configure the db machine with a different IP from the app
Provision the db machine with a MongoDB database
In Vagrantfile:
First version
```
Vagrant.configure("2") do |config|
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network "private_network", ip: "192.168.10.100"
    app.hostsupdater.aliases = ["development.local"]
    app.vm.synced_folder "app", "/app"
    app.vm.provision "shell", path: "environment/app/provision.sh", privileged: false
  end
  config.vm.define "db" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network "private_network", ip: "192.168.10.101"
    app.hostsupdater.aliases = ["development.local"]
    app.vm.provision "shell", path: "environment/db/provision.sh"
  end
```

in provision:
```
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

# install pm2
sudo npm install pm2 -g

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y
sudo apt-get install mongodb-org=3.2.20 -y
sudo systemctl start mongod
sudo systemctl enable mongod
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
sudo systemctl restart mongod.service
```


### Notes
When you have the second machine running further configuration of the app is required to make it use the databse. We will cover this in the next lesson.
You can test your database is working correctly by running the test suite in the test folder. There are two sets of tests. One for the app VM and one for the db VM. Make them all pass.
