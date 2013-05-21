if node["platform"] == "mac_os_x"

  dmg_package "TrueCrypt" do
    source "http://www.truecrypt.org/download/TrueCrypt%20#{version}%20Mac%20OS%20X.dmg"
    checksum "04db58b737c05bb6b0b83f1cb37a29edec844b59ff223b9e213ee1f4e287f586"
    action :install
    type "pkg"
    owner WS_USER
    package_id "org.truecrypt.truecrypt"
  end

else

  version = "7.1a"
  files = {
    "console-x64" => {
      :checksum => "3f48210cca1c17f433572845586d5e2a1a717a545480d136cb970689a44e3c32",
      :cp => "truecrypt-cmd"
    },
    "x64" => {
      :checksum => "43f895cfcdbe230907c47b4cd465e5c967bbe741a9b68512c09f809d1a2da1e9",
      :cp => "truecrypt-gui"
    },
  }

  files.each do |file, params|

    remote_file "#{Chef::Config[:file_cache_path]}/truecrypt-#{version}-linux-#{file}.tar.gz" do
      source "http://www.truecrypt.org/download/truecrypt-#{version}-linux-#{file}.tar.gz"
      checksum params[:checksum]
    end

    directory "/tmp/#{file}" do
      owner "root"
      group "root"
      mode "0755"
    end

    execute "extract truecrypt-#{version}-setup-#{file}" do
      command "tar xzf #{Chef::Config[:file_cache_path]}/truecrypt-#{version}-linux-#{file}.tar.gz -C /tmp/#{file}/"
    end

    bash "extract archive from truecrypt-#{version}-setup-#{file}" do
      cwd "/tmp/#{file}"
      code <<-EOH
          set +e
          START=`grep -E --text "^PACKAGE_START=([0-9]+)$" /tmp/#{file}/truecrypt-#{version}-setup-#{file} | cut -d = -f 2`
          tail -n +$START /tmp/#{file}/truecrypt-#{version}-setup-#{file} > /tmp/#{file}/truecrypt-#{version}-setup-#{file}-internal.tar.gz
      EOH
    end

    bash "install truecrypt-#{file}" do
      code <<-EOH
        set +e
        tar xzf /tmp/#{file}/truecrypt-#{version}-setup-#{file}-internal.tar.gz -C /tmp/#{file}/
        cp /tmp/#{file}/usr/bin/truecrypt /usr/bin/#{params[:cp]}
      EOH
    end
  end

end
