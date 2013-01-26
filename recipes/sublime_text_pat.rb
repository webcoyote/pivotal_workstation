require 'uri'

# Yuck - I'd be glad to get feedback on how a
# real chef would handle this.
class Chef::Recipe
  class Sublime

    def self.extension (node)
      if node["platform"] != "mac_os_x"
        " x64.tar.bz2"
      else
        ".dmg"
      end
    end

    def self.filename (node)
      "Sublime Text #{node['sublime_text'][:version]}#{self.extension(node)}"
    end

    def self.srcdir (node)
      if node["platform"] != "mac_os_x"
        "/opt/subl"
      else
        "#{WS_HOME}/Library/Application Support/Sublime Text 2"
      end
    end

    def self.dstdir (node)
      if node["platform"] != "mac_os_x"
        "/opt/subl"
      else
        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin"
      end
    end

    def self.dstfile (node)
      if node["platform"] != "mac_os_x"
        "#{Sublime::dstdir(node)}/sublime_text"
      else
        "#{Sublime::dstdir(node)}/subl"
      end
    end

    def self.srcdir_owner (node)
      if node["platform"] != "mac_os_x"
        'root'
      else
        WS_USER
      end
    end

    def self.download_url (node)
      URI.escape "#{node['sublime_text'][:download_url]}/#{self.filename(node)}"
    end

  end
end

# Create directory where Sublime is installed
directory Sublime::srcdir(node) do
  owner Sublime::srcdir_owner(node)
end

# Unpack and install
if node["platform"] != "mac_os_x"

  execute "Download Sublime Text 2" do
    command "curl -L #{Sublime::download_url(node)} -o '/tmp/#{Sublime::filename(node)}'"
    not_if {
      File.exist?("/tmp/#{Sublime::filename(node)}") ||
       File.exist?("#{Sublime::dstdir(node)}/sublime_text")
    }
  end

  execute "Unpack Sublime Text 2" do
    command "tar --strip-components=1 -C '#{Sublime::dstdir(node)}' -xjf '/tmp/#{Sublime::filename(node)}'"
    not_if { File.exist?("#{Sublime::dstdir(node)}/sublime_text") }
  end

else

  dmg_package "Sublime Text 2 (Mac)" do
    dmg_name URL.escape(Sublime::filename(node))
    source Sublime::download_url(node)
    checksum "b5f91ee4f62d36c0490c021d5fb134b9e7cb3936"
    owner WS_USER
  end

end


link "/usr/local/bin/subl" do
  to Sublime::dstfile(node)
end

