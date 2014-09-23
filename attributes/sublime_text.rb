# Sublime Text application version
default['sublime_text']['version'] = '2'

# Sublime Text 2
default['sublime_text']['2']['osx'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.dmg',
}
default['sublime_text']['2']['debian'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2',
}

# Sublime Text 3
default['sublime_text']['3']['osx'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203065.dmg',
}
default['sublime_text']['3']['debian'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2',
}

# Packages
default["sublime_text_packages"] = [
  {"name" => "Theme - Soda", "source" => "https://github.com/buymeasoda/soda-theme"}
]
