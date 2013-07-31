#def local_cache(box_name, purpose)
#  cache_dir = File.join(File.expand_path(Vagrant::Environment::DEFAULT_HOME),
#                        'cache',
#                        purpose,
#                        box_name)
#  partial_dir = File.join(cache_dir, 'partial')
#  FileUtils.mkdir_p(partial_dir) unless File.exists? partial_dir
#  cache_dir
#end

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.provision :shell, :inline => $BOOTSTRAP_SCRIPT # see below
  config.vm.network :forwarded_port, guest: 8080, host: 8081 # Web

  # apt package caching
  #config.vm.synced_folder (local_cache config.vm.box, 'apt'), "/var/cache/apt/archives/"

  # pip package cache
  #config.vm.synced_folder (local_cache config.vm.box, 'pip'), "/var/cache/pip/"
end

$BOOTSTRAP_SCRIPT = <<EOF
	set -e # Stop on any error

	# --------------- SETTINGS ----------------
	# Other settings
	export DEBIAN_FRONTEND=noninteractive

	sudo apt-get update
	sudo apt-get install -y python-software-properties build-essential gcc g++
	sudo add-apt-repository ppa:chris-lea/node.js
	sudo apt-get update
	sudo apt-get install -y
	sudo apt-get install -y coffeescript
	# nodejs

	echo READY.
EOF
