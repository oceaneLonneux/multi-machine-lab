# Install required plugins
required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

def create_env_var(obj)
  string = <<~HEREDOC
  HEREDOC
  obj.each do |key, val|
      string += <<~HEREDOC
        echo #{key}: #{val}
        echo "export #{key}=#{val}" >> ~/.bashrc
    HEREDOC
  end
    string += <<~HEREDOC
      source ~/.bashrc
    HEREDOC
end

Vagrant.configure("2") do |config|
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network "private_network", ip: "192.168.10.100"
    app.hostsupdater.aliases = ["development.local"]
    app.vm.synced_folder "app", "/app"
    app.vm.provision "shell", path: "environment/app/provision.sh", privileged: false
    app.vm.provision "shell", inline: create_env_var({DB_HOST:"192.168.10.101"}), privileged: false
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.101"
    db.hostsupdater.aliases = ["db.local"]
    db.vm.synced_folder("environment/db", '/home/ubuntu/environment')
    # it allows us to access directly the virtual machine with the db or app we want
    db.vm.provision "shell", path: "environment/db/provision.sh", privileged: false
  end
end
