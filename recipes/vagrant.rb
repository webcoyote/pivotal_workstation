
# VirtualBox no longer required for vagrant
#include_recipe "pivotal_workstation::virtualbox"

if node["platform"] == "mac_os_x"

  dmg_package "Vagrant" do
    source node['vagrant']['osx']['url']
    checksum ['vagrant']['osx']['checksum']
    action :install
    type "pkg"
    owner WS_USER
    package_id "com.vagrant.vagrant"
  end

else

  srcfile = "#{Chef::Config[:file_cache_path]}/vagrant.deb"
  remote_file srcfile do
    source node['vagrant'][node["platform_family"]]['url']
    checksum node['vagrant'][node["platform_family"]]['checksum']
    mode 0644
  end

  dpkg_package "vagrant" do
    source srcfile
    action :install
  end

end

#
#node_attributes:
#  vagrant_plugins:
#    - vagrant-aws
#    - vagrant-berkshelf

(node['vagrant_plugins'] || []).each do |name|
  execute "vagrant plugin install #{name}" do
    user WS_USER
  end
end
