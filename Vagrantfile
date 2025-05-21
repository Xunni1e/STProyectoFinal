Vagrant.configure("2") do |config|
  config.vm.define "proxysql" do |proxysql|
    proxysql.vm.box = "bento/ubuntu-22.04"
    proxysql.vm.hostname = "proxysql"
    proxysql.vm.network "private_network", ip: "192.168.100.10"
    proxysql.vm.provision "shell", path: "scripts/proxysql-init.sh"
  end

  config.vm.define "mysqlmaster" do |mysqlmaster|
    mysqlmaster.vm.box = "bento/ubuntu-22.04"
    mysqlmaster.vm.hostname = "mysqlmaster"
    mysqlmaster.vm.network "private_network", ip: "192.168.100.20"
    mysqlmaster.vm.provision "shell", path: "scripts/master-init.sh"
  end

  (1..2).each do |i|
    config.vm.define "mysqlslave#{i}" do |slave|
      slave.vm.box = "bento/ubuntu-22.04"
      slave.vm.hostname = "mysqlslave#{i}"
      slave.vm.network "private_network", ip: "192.168.100.2#{i}"
      slave.vm.provision "shell", path: "scripts/slave-init.sh"
    end
  end
end
