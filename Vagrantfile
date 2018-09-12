# Install required plugins
required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure("2") do |config|
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network "private_network", ip: "192.168.10.100"
    app.hostsupdater.aliases = ["development.local"]
    app.vm.synced_folder "app", "/app"
    app.vm.provision "shell", path: "environment/app/provision.sh", privileged: false
  end
  config.vm.define "db" do |db|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network "private_network", ip: "192.168.10.101"
    app.hostsupdater.aliases = ["db.local"]
    # it allows us to access directly the virtual machine with the db or app we want
    app.vm.provision "shell", path: "environment/db/provision.sh"
  end

end
