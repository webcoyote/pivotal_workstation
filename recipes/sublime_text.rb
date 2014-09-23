require 'uri'

# Isolate platform-dependent information in a class
class Chef::Recipe
  class Sublime

    def self.version (node)
      node['sublime_text']['version'].to_s
    end

    def self.config_dir_array (node)
      if node["platform"] != "mac_os_x"
        ["#{WS_HOME}", ".config", "sublime-text-#{Sublime::version(node)}"]
      else
        ["#{WS_HOME}/Library/Application Support", "Sublime Text #{Sublime::version(node)}"]
      end
    end

    def self.dstdir (node)
      if node["platform"] != "mac_os_x"
        "/opt/subl#{Sublime::version(node)}"
      else
        "/Applications/Sublime Text #{Sublime::version(node)}.app/Contents/SharedSupport/bin"
      end
    end

    def self.dstfile (node)
      if node["platform"] != "mac_os_x"
        "#{Sublime::dstdir(node)}/sublime_text"
      else
        "#{Sublime::dstdir(node)}/subl"
      end
    end

  end
end

# Create directory where Sublime is installed
directory Sublime::dstdir(node) do
  owner WS_USER
end

# Unpack and install
if node["platform"] != "mac_os_x"

  srcfile = "#{Chef::Config[:file_cache_path]}/Sublime-#{Sublime::version(node)}.pkg"
  remote_file srcfile do
    source node['sublime_text'][Sublime::version(node)][node['platform_family']]['url']
  end

  execute "Unpack Sublime Text" do
    command "tar --strip-components=1 -C '#{Sublime::dstdir(node)}' -xjf '#{srcfile}'"
  end

else

  dmg_package "Sublime Text #{Sublime::version(node)}" do
    source node['sublime_text'][Sublime::version(node)]['osx']['url']
    action :install
    owner WS_USER
  end

end

[ "", Sublime::version(node) ].each do |v|

  # Create subl, subl2 (for Sublime 2)
  link "/usr/local/bin/subl#{v}" do
    to Sublime::dstfile(node)
  end

  # Create e, e2 (for Sublime 2)
  template "/usr/local/bin/e#{v}" do
    mode '0755'
    source "sublime_text.sh.erb"
    owner WS_USER
  end

end

# Install packages list in attributes
packages_dir_array = Sublime::config_dir_array(node) << "Packages"
recursive_directories packages_dir_array do
  owner WS_USER
end

node["sublime_text_packages"].each do |package|
  pivotal_workstation_sublime_package package["name"] do
    source package["source"]
    destination File.join(packages_dir_array)
    owner WS_USER
  end
end


# Configure user settings
settings_dir = File.join(packages_dir_array, "User")
directory settings_dir do
  owner WS_USER
end

template File.expand_path("Preferences.sublime-settings", settings_dir) do
  source "sublime_text-Preferences.sublime-settings.erb"
  owner WS_USER

  # Don't blast over any customizations the user may have
  # made since the last chef run; that would be rude
  action :create_if_missing
end


# Install Package Control, the essential Sublime Text plugin
pkgcontrol_dir = File.join(Sublime::config_dir_array(node), "Installed Packages")
directory pkgcontrol_dir do
  owner WS_USER
end

remote_file "#{pkgcontrol_dir}/Package Control.sublime-package" do
  source 'http://sublime.wbond.net/Package%20Control.sublime-package'
  owner WS_USER
end
