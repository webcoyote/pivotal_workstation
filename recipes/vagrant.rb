
# VirtualBox no longer required for vagrant
#include_recipe "pivotal_workstation::virtualbox"

if node["platform"] == "mac_os_x"

  dmg_package "Vagrant" do
    source "http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/Vagrant-1.2.2.dmg"
    checksum "1581552841e076043308f330a5b1130b455c604846116c54b5330bb17240c7ee"
    action :install
    type "pkg"
    owner WS_USER
    package_id "com.vagrant.vagrant"
  end

else

  srcfile = "#{Chef::Config[:file_cache_path]}/vagrant_1.2.2_x86_64.deb"
  remote_file srcfile do
    source "http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64.deb"
    checksum "d3035d259a28bd7090ef00629e61cc0520778143fad06f49adb3c45a75fb1425"
    mode 0644
  end

  dpkg_package "vagrant" do
    source srcfile
    action :install
  end

end
