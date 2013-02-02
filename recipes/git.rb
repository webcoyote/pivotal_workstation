include_recipe "pivotal_workstation::homebrew"

if node["platform"] != "mac_os_x"
  package "git"
else
  brew_install "git"
end

# Configure git
(node["git"] || []).each do |key, value|
  cmd = %Q[git config --global #{key} "#{value}"]
  execute cmd do
    command cmd
  end
end
