return if node["platform"] == "mac_os_x"

# Recipe to install linux packages
#
# Repositories should be defined as an array in the node_attributes section of
# your `soloistrc` file. eg:
#
# node_attributes:
#   linux-packages:
#     -
#       - package-name1     # installs for any Linux platform
#     -
#       - package-name2
#       - amazon centos     # only installs on named Linux platforms
#
# See http://docs.opscode.com/dsl_recipe_method_platform.html

node['linux-packages'].each do |name, platforms|
  next unless platforms.nil? || platforms.split.any? { |p| platform?(p) }
  package name
end
