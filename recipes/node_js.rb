if node["platform"] == "mac_os_x"
  brew "node"
else
  basefile = "node-v#{node['node_js'][:version]}-linux-x64"
  remote_file "#{Chef::Config[:file_cache_path]}/#{basefile}.tar.gz" do
    source "http://nodejs.org/dist/v#{node['node_js'][:version]}/#{basefile}.tar.gz"
  end

  directory "/usr/local/node" do
  end

  execute "extract node" do
    command "tar -xzf #{Chef::Config[:file_cache_path]}/#{basefile}.tar.gz -C /usr/local/node --strip-components=1"
  end
end
