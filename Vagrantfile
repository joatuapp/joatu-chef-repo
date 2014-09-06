# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = :latest

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/ubuntu-14.04"
  # config.vm.box = "chef/ubuntu-12.04"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.librarian_chef.cheffile_dir = "./"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #
  config.vm.define "joatu_staging" do
    config.vm.network :forwarded_port, guest: 80, host: 8080
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../intercity-chef-repo", "/intercity-chef-repo"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    # vb.gui = true

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", 2]
  end

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "2"
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  json_payload = {
    "authorization" => {
      "sudo" => {
        "users" => ["vagrant"]
      }
    },
    "postgresql" => {
      "password" => {
        "postgres" => "joatu_staging"
      }
    },
    "active_applications" => {
      "joatu_app" => {
        ruby_version: "2.1.2",
        domain_names: ["api.joatu.local", "joatu.local"],
        packages: [],
        rails_env: "staging",
        "database_info" => {
          host: "localhost",
          username: "joatu_app",
          password: "joatu_staging",
          database: "joatu_staging"
        },
        "env_vars" => {
          "SECRET_KEY_BASE" => "5c11bffd8ad6d537fc291c4b4089a42a2f40ee6869d75490eef944196b3b601053a8d9c2f5c29aa8738fa786f5c14dd5a6fab1b5537095c2c5ed3f2567392463"
        }
      }
    },
    "ssh_deploy_keys" => [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDea3sUR/Z4LKX/o8i4/j4hJZb1EL8IfxshkitVjW10daspV7hSKWYvDpTQbSt6tYq7FKroEl1PXFwVPdk5Xo4lpgVj/LM3qLAqkMHjyZUnx5VcXTjOVYfXuJsdgwvj/kbvjGrLL68/jbUiPoKymQNE+2tslA6TSXsrp5foQRQQ0BKmJKfzmjzsR/UHTFs6VKe8U45OHgYgmW6n8xSDEh5URR4yRwDCPl/LHXAchlkXlOQVYuooENIzqoJJPJlPlMO7Ib/3B8qAzb6c8MZcbl67tylO+87mhN1VcpuFwI4NCEHHke6n4XscXFtqFHd17wJ7RH83F4Bx67O0H3QAN3vH alex@undergroundwebdevelopment.com",
    ],
  }

  config.vm.define "joatu_staging" do

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "./cookbooks"
      chef.roles_path = "./roles"

      chef.add_role "postgresql"
      chef.add_role "rails"

      chef.log_level = :info

      if json_payload["active_applications"].size > 0
        json_payload["active_applications"].each_value do |app|
          app["database_info"]["adapter"] = "postgresql"
        end
      end

      # You may also specify custom JSON attributes:
      chef.json = json_payload
    end

  end

end
