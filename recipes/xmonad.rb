package "xmonad"

directory "/home/#{WS_USER}/.xmonad" do
  owner WS_USER
  group WS_USER
  mode '0755'
  recursive true
end

template "/home/#{WS_USER}/.xmonad/xmonad.hs" do
  source "xmonad.hs"
  owner WS_USER
  group WS_USER
  mode '0644'
  action :create_if_missing
end

execute "recompile xmonad.hs for #{WS_USER}" do
  command "sudo su #{user WS_USER} -c 'cd /home/#{WS_USER} && bash -c \"/usr/bin/xmonad --recompile\"'"
  creates "/home/#{WS_USER}/.xmonad/xmonad-x86_64-linux"
end

# To check window manager, run this:
# gconftool-2 -g /desktop/gnome/session/required_components/windowmanager
execute "Set window manager to xmonad for #{WS_USER}" do
  command "gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string"
  user WS_USER
end

directory "/home/#{WS_USER}/.config" do
  owner WS_USER
  group WS_USER
  mode '0755'
  recursive true
end

directory "/home/#{WS_USER}/.config/autostart" do
  owner WS_USER
  group WS_USER
  mode '0755'
  recursive true
end

template "/home/#{WS_USER}/.config/autostart/xmodmap.desktop" do
  source "xmodmap.desktop"
  owner WS_USER
  group WS_USER
  mode '0644'
  action :create_if_missing
end

template "/etc/init.d/xmonadkey" do
  source "xmonadkey.sh"
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

# RedHat uses runlevel 5 for graphics mode. Debian usually
# uses 2 but can use anything from 2..5 so set them all
(2..5).each do |runlevel|
  link "/etc/rc#{runlevel}.d/S90xmonadkey" do
    to "/etc/init.d/xmonadkey"
    link_type :symbolic
    owner 'root'
    group 'root'
  end
end
