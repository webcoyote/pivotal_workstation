if node['meld']['install_method'] == 'package'

  package "meld"

else

  filename = File.basename(node['meld']['source']['url'])
  srcfile = "#{Chef::Config[:file_cache_path]}/#{filename}"
  remote_file srcfile do
    source node['meld']['source']['url']
    checksum node['meld']['source']['checksum']
  end

  directory "/opt/meld" do
    mode 0755
  end

  execute "extract meld" do
    command "tar --strip-components=1 -xf '#{srcfile}' -C /opt/meld"
  end

end

# Configure git unless otherwise requested
config = node["meld"] || {}
if (config["configure-git"] || 1) != 0

  [
    %q[git config --global diff.tool meld],
    %q[git config --global difftool.prompt false],
    %q[git config --global difftool.meld.cmd 'meld "$LOCAL" "$REMOTE"'],
    %q[git config --global merge.tool meld],
    %q[git config --global merge.conflictstyle diff3],
    %q[git config --global mergetool.prompt false],
    %q[git config --global mergetool.meld.trustExitCode false],
    %q[git config --global mergetool.meld.cmd 'meld "$LOCAL" "$BASE" "$REMOTE" "$MERGED"'],
  ].each do |cmd|
    execute cmd do
      command cmd
      user WS_USER
    end
  end

end
