if node["platform"] != "mac_os_x"
  package "git"
else
  brew "git"
end

# Configure git
(node["git"] || []).each do |key, value|
  cmd = %Q[git config --global #{key} "#{value}"]
  execute cmd do
    command cmd
  end
end

