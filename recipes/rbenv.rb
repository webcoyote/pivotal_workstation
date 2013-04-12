::RBENV_HOME = "#{WS_HOME}/.rbenv"
::RBENV_COMMAND = "#{RBENV_HOME}/bin/rbenv"

if node["platform"] == "mac_os_x"
  include_recipe "pivotal_workstation::git"
  brew "rbenv"
  brew "ruby-build"
else
  git "#{RBENV_HOME}" do
    repository 'git://github.com/sstephenson/rbenv.git'
    user WS_USER
    group WS_USER
    reference 'master'
    action :sync
  end
  directory "#{RBENV_HOME}/plugins" do
    owner WS_USER
    group WS_USER
    mode '0755'
  end
  git "#{RBENV_HOME}/plugins/ruby-build" do
    repository 'git://github.com/sstephenson/ruby-build.git'
    user WS_USER
    group WS_USER
    reference 'master'
    action :sync
  end
end

pivotal_workstation_bash_it_enable_feature "plugins/rbenv"

node["rbenv"]["rubies"].each do |version, options|
  rbenv_ruby_install version do
    options options
  end
end

execute "making #{node["rbenv"]["default_ruby"]} with rbenv the default" do
  not_if { node["rbenv"]["default_ruby"].nil? }
  command "#{RBENV_COMMAND} global #{node["rbenv"]["default_ruby"]}"
  user WS_USER
end
