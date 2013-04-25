version = "13.1"

if node["platform"] != "mac_os_x"
  remote_file "/usr/local/bin/p4" do
    source "http://filehost.perforce.com/perforce/r#{version}/bin.linux26x86_64/p4"
    mode '0755'
  end
end
