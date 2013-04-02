if node["platform"] != "mac_os_x"
  package "zsh"
else
  brew "zsh"
end
