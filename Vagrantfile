# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

DB_PRIVATE_IP = "192.168.70.4"
ATG_PRIVATE_IP = "192.168.70.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :db do |db_config|

    db_config.vm.box = "chef/centos-6.5"
    db_config.vbguest.auto_update = true

    # change memory size
    db_config.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end

    # static IP so we can configure machines to talk to each other
    db_config.vm.network "private_network", ip: DB_PRIVATE_IP

    # provisioning script converts to oracle linux and installs db prereqs
    db_config.vm.provision "shell", path: "scripts/db/provision_setup.sh"

    # installs oracle 11.2.0.4.0
    db_config.vm.provision "shell", path: "scripts/db/provision_install.sh"

    # runs oracle postinstallation tasks as root
    db_config.vm.provision "shell", path: "scripts/db/provision_postinstall.sh"    

    # installs tns listener and creates empty db
    db_config.vm.provision "shell", path: "scripts/db/provision_netca_dbca.sh"        

    # imports the ATG CRS db dump
    db_config.vm.provision "shell", path: "scripts/db/provision_import.sh" 

    # sets up the init.d service
    db_config.vm.provision "shell", path: "scripts/db/provision_service_setup.sh"  
  end

  # ==============================

  config.vm.define :atg do |atg_config|
    atg_config.vm.box = "chef/centos-6.5"
    atg_config.vbguest.auto_update = true

    # change memory size
    atg_config.vm.provider "virtualbox" do |v|
      v.memory = 6144
    end

    atg_config.vm.network "private_network", ip: ATG_PRIVATE_IP

    # provisioning script converts to oracle linux 
    atg_config.vm.provision "shell", path: "scripts/atg/provision_setup.sh"

    # install software
    atg_config.vm.provision "shell", path: "scripts/atg/provision_install_endeca.sh", privileged: false
    atg_config.vm.provision "shell", path: "scripts/atg/provision_service_setup.sh"
    atg_config.vm.provision "shell", path: "scripts/atg/provision_install_atg.sh", privileged: false
    atg_config.vm.provision "shell", path: "scripts/atg/provision_install_crs_artifacts.sh", privileged: false

  end

end
