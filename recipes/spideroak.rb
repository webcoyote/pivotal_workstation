if node["platform"] == "mac_os_x"

  dmg_package "spideroak" do
    source node['spideroak']['osx']['url']
    checksum ['spideroak']['osx']['checksum']
    action :install
    type "pkg"
    owner WS_USER
  end

else

  srcfile = "#{Chef::Config[:file_cache_path]}/spideroak.deb"
  remote_file srcfile do
    source node['spideroak'][node["platform_family"]]['url']
    checksum node['spideroak'][node["platform_family"]]['checksum']
    mode 0644
  end

  dpkg_package "spideroak" do
    source srcfile
    action :install
  end

  execute "make spideroak nice" do
    command %q{sed --in-place -e 's/^exec "/exec nice "/' /usr/bin/SpiderOak}
  end

end
