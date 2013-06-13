version = "13.1"

if node["platform"] != "mac_os_x"
  remote_file "#{Chef::Config[:file_cache_path]}/p4v.tgz" do
    source "http://filehost.perforce.com/perforce/r#{version}/bin.linux26x86_64/p4v.tgz"
    checksum "3a96bec07459cde5720d46a94b4c6299c737176bbf2f91f5867e90a52feec487"
  end

  directory "/opt/p4v"

  execute "extract p4v" do
    command "tar -xzf #{Chef::Config[:file_cache_path]}/p4v.tgz -C /opt/p4v --strip-components=1"
  end

  link "/usr/local/bin/p4v" do
    to "/opt/p4v/bin/p4v"
  end

end

