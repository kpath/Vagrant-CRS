# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

DB_PRIVATE_IP = "192.168.70.4"
ATG_PRIVATE_IP = "192.168.70.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

config.vm.define :db12c do |db12c_config|
    db12c_config.vm.box = "opscode-centos-6.6"
    db12c_config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box"

    # change memory size
    db12c_config.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end

    # static IP so we can configure machines to talk to each other
    db12c_config.vm.network "private_network", ip: DB_PRIVATE_IP

    # provision
    db12c_config.vm.provision "shell" do |s|
        s.path = "scripts/db12c/provision.sh"
        s.args = ENV['DB12C_PROVISION_ARGS']
    end
end

  # ============================

  config.vm.define :db11g do |db11g_config|
    db11g_config.vm.box = "opscode-centos-6.6"
    db11g_config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box"

    # change memory size
    db11g_config.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end

    # static IP so we can configure machines to talk to each other
    db11g_config.vm.network "private_network", ip: DB_PRIVATE_IP

    # provision
    db11g_config.vm.provision "shell" do |s|
        s.path = "scripts/db11g/provision.sh"
        s.args = ENV['DB11G_PROVISION_ARGS']
    end
end

  # ==============================

  config.vm.define :atg do |atg_config|
    atg_config.vm.box = "opscode-centos-6.6"
    atg_config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box"

    # change memory size
    atg_config.vm.provider "virtualbox" do |v|
      v.memory = 6144
    end

    # static IP so we can configure machines to talk to each other
    atg_config.vm.network "private_network", ip: ATG_PRIVATE_IP

    # provision
    atg_config.vm.provision "shell" do |s|
        s.path = "scripts/atg/provision.sh"
        s.args = ENV['ATG_PROVISION_ARGS']
    end

  end

end

module UpdateCentOSKernel
    class UpdateCentOSKernelPlugin < Vagrant.plugin('2')
        name 'update_centos_kernel_plugin'

        # update yum after first boot when provisioning
        action_hook(:update_yum, :machine_action_up) do |hook|
            hook.after(VagrantPlugins::ProviderVirtualBox::Action::CheckGuestAdditions, UpdateCentOSKernel::Middleware::KernelUpdater)
        end
    end

    module Middleware
        class KernelUpdater
            @@rebooted = {};

            def initialize(app, env)
                @app = app
            end

            def call(env)
                @env = env
                @vm = env[:machine]
                @ui = env[:ui]
                self.update_kernel()
            end

            def update_kernel()
                if !@@rebooted[@vm.id]
                    @@rebooted[@vm.id] = true

                    @ui.info 'Updating kernel'
                    @vm.communicate.sudo('yum install -y kernel kernel-devel') do |type, data|
                        if type == :stderr
                            @ui.error(data);
                        else
                            @ui.info(data);
                        end
                    end

                    self.reboot()
                end
            end

            def reboot()
                @ui.info('Rebooting after updating kernel')
                simle_reboot = Vagrant::Action::Builder.new.tap do |b|
                    b.use Vagrant::Action::Builtin::Call, Vagrant::Action::Builtin::GracefulHalt, :poweroff, :running do |env2, b2|
                        if !env2[:result]
                            b2.use VagrantPlugins::ProviderVirtualBox::Action::ForcedHalt
                        end
                    end

                    b.use VagrantPlugins::ProviderVirtualBox::Action::Boot
                    if defined?(Vagrant::Action::Builtin::WaitForCommunicator)
                        b.use Vagrant::Action::Builtin::WaitForCommunicator, [:starting, :running]
                    end
                    b.use VagrantVbguest::Middleware
                end
                @env[:action_runner].run(simle_reboot, @env)
            end
        end
    end
end
