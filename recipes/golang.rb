if node["platform"] == "mac_os_x"
  raise "unimplemented"
else

  basefile = "go#{node['golang'][:version]}.linux-amd64"
  run_unless_marker_file_exists(basefile) do
    remote_file "#{Chef::Config[:file_cache_path]}/#{basefile}.tar.gz" do
      source "http://go.googlecode.com/files/#{basefile}.tar.gz"
      checksum "97299d1989936b90d0c51ec8028d1f5dca8df6b6"
    end

    execute "remove old go version" do
      command "rm /usr/local/go -rf"
    end

    execute "extract golang" do
      command "tar -xzf #{Chef::Config[:file_cache_path]}/#{basefile}.tar.gz -C /usr/local"
    end
  end

end
