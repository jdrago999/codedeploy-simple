#!/usr/bin/env ruby

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'ubuntu/trusty64'

  # vagrant-berkshelf is incompatible with vagrant-librarian-chef
  if Vagrant.has_plugin?('vagrant-berkshelf')
    config.berkshelf.enabled = false
  end

  # If this Vagrantfile is in /foo/bar/baz then set the hostname to 'baz':
  config.vm.network 'private_network', type: :dhcp
  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
  end
  config.vm.synced_folder './', '/opt/codedeploy'

  config.omnibus.chef_version = :latest
  config.librarian_chef.cheffile_dir = 'chef'
  config.vm.provision 'chef_solo' do |chef|
    chef.cookbooks_path = ['chef/cookbooks', 'chef/site-cookbooks']
    chef.run_list = ['codedeploy::default']
    chef.json = {
      'codedeploy' => {
        'aws_access_key_id' => ENV['AWS_ACCESS_KEY_ID'],
        'aws_secret_access_key' => ENV['AWS_SECRET_ACCESS_KEY'],
      }
    }
  end

  # Force install the latest cookbooks from source:
  `cd chef && librarian-chef install && librarian-chef update`
end
