# -*- mode: ruby -*-
# vi: set ft=ruby :

require "json"

def read(filename = "config.json")
  file = nil
  data = nil

  if(!File.exist?(filename))
    puts "File '#{filename}' does not exist."
    return nil
  end

  begin
    file = File.read(filename)
  rescue
    puts "Cannot read in '#{filename}' file."
    return nil
  end

  begin
    data = JSON.parse(file)
  rescue
    puts "Unable to parse JSON from '#{filename}' file."
    return nil
  end

  return data
end

cfg = read

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessable to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "k8s-control-plane", primary: true do |ctl|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    ctl.vm.box = "bento/ubuntu-22.04"

    # The hostname the machine should have.
    # If set to a string, the hostname will be set on boot.
    # If set, Vagrant will update /etc/hosts on the guest with the configured hostname.
    ctl.vm.hostname = cfg["machines"][0]["name"]

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    ctl.vm.network "private_network", ip: cfg["machines"][0]["address"]

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    ctl.vm.provider "parallels" do |prl|

      # You can customize the virtual machine name that appears in the Parallels Desktop GUI.
      # By default, Vagrant sets it to the name of the folder containing the Vagrantfile plus a timestamp of when the machine was created.
      prl.name = cfg["machines"][0]["name"]

      # Full clone is a full image copy, which is totally independent from the box.
      prl.linked_clone = false

      # Sets the number of CPUs to be available to the virtual machine.
      prl.cpus = 2

      # Sets the amount of memory for the virtual machine (in megabytes).
      prl.memory = 4096
    end

    # Enable provisioning with a shell script.
    # Path to a shell script to upload and execute.
    ctl.vm.provision "shell",
      path: "hostname.sh",
      args: [
        cfg["machines"][1]["address"],
        cfg["machines"][1]["name"],
        cfg["machines"][2]["address"],
        cfg["machines"][2]["name"]
      ],
      privileged: false

    # Enable provisioning with a shell script.
    # Path to a shell script to upload and execute.
    ctl.vm.provision "shell",
      path: "configure.sh",
      privileged: false

    # Enable provisioning with a shell script.
    # Path to a shell script to upload and execute.
    ctl.vm.provision "shell",
      path: "cluster.sh",
      args: cfg["machines"][0]["address"],
      privileged: false
  end

  config.vm.define "k8s-worker-one" do |wrkr1|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    wrkr1.vm.box = "bento/ubuntu-22.04"

    # The hostname the machine should have.
    # If set to a string, the hostname will be set on boot.
    # If set, Vagrant will update /etc/hosts on the guest with the configured hostname.
    wrkr1.vm.hostname = cfg["machines"][1]["name"]

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    wrkr1.vm.network "private_network", ip: cfg["machines"][1]["address"]

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    wrkr1.vm.provider "parallels" do |prl|

      # You can customize the virtual machine name that appears in the Parallels Desktop GUI.
      # By default, Vagrant sets it to the name of the folder containing the Vagrantfile plus a timestamp of when the machine was created.
      prl.name = cfg["machines"][1]["name"]

      # Full clone is a full image copy, which is totally independent from the box.
      prl.linked_clone = false

      # Sets the number of CPUs to be available to the virtual machine.
      prl.cpus = 2

      # Sets the amount of memory for the virtual machine (in megabytes).
      prl.memory = 4096
    end

    # Enable provisioning with a shell script.
    # Path to a shell script to upload and execute.
    wrkr1.vm.provision "shell",
      path: "hostname.sh",
      args: [
        cfg["machines"][0]["address"],
        cfg["machines"][0]["name"],
        cfg["machines"][2]["address"],
        cfg["machines"][2]["name"]
      ],
      privileged: false

    # Enable provisioning with a shell script.
    # Path to a shell script to upload and execute.
    wrkr1.vm.provision "shell",
      path: "configure.sh",
      privileged: false
  end

  config.vm.define "k8s-worker-two" do |wrkr2|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    wrkr2.vm.box = "bento/ubuntu-22.04"

    # The hostname the machine should have.
    # If set to a string, the hostname will be set on boot.
    # If set, Vagrant will update /etc/hosts on the guest with the configured hostname.
    wrkr2.vm.hostname = cfg["machines"][2]["name"]

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    wrkr2.vm.network "private_network", ip: cfg["machines"][2]["address"]

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    wrkr2.vm.provider "parallels" do |prl|

      # You can customize the virtual machine name that appears in the Parallels Desktop GUI.
      # By default, Vagrant sets it to the name of the folder containing the Vagrantfile plus a timestamp of when the machine was created.
      prl.name = cfg["machines"][2]["name"]

      # Full clone is a full image copy, which is totally independent from the box.
      prl.linked_clone = false

      # Sets the number of CPUs to be available to the virtual machine.
      prl.cpus = 2

      # Sets the amount of memory for the virtual machine (in megabytes).
      prl.memory = 4096
    end

    # Enable provisioning with a shell script.
    # Path to a shell script to upload and execute.
    wrkr2.vm.provision "shell",
      path: "hostname.sh",
      args: [
        cfg["machines"][0]["address"],
        cfg["machines"][0]["name"],
        cfg["machines"][1]["address"],
        cfg["machines"][1]["name"]
      ],
      privileged: false

    # Enable provisioning with a shell script.
    # Path to a shell script to upload and execute.
    wrkr2.vm.provision "shell",
      path: "configure.sh",
      privileged: false
  end

  # Enable provisioning with a shell script.
  # Specifies a shell command inline to execute on the remote machine.
  config.vm.provision "shell",
    inline: "sudo swapoff -a",
    run: "always",
    privileged: false
end
