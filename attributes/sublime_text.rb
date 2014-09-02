# Sublime Text application version
default['sublime_text']['version'] = '2'

# Sublime Text 2
default['sublime_text']['2']['osx'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.dmg',
  'checksum' => '906e71e19ae5321f80e7cf42eab8355146d8f2c3fd55be1f7fe5c62c57165add'
}
default['sublime_text']['2']['debian'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2',
  'checksum' => '01baed30d66432e30002a309ff0393967be1daba5cce653e43bba6bd6c38ab84'
}

# Sublime Text 3
default['sublime_text']['3']['osx'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203065.dmg',
  'checksum' => '373dbfcddab7fb288351763402361cd4045f4a9510eb32f81938d0c156d161c3'
}
default['sublime_text']['3']['debian'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2',
  'checksum' => 'fe548e6d86d72cd7e90eee9d5396b590ae6e8f8b0dfc661d86c814214e60faea'
}

# Packages
default["sublime_text_packages"] = [
  {"name" => "Theme - Soda", "source" => "https://github.com/buymeasoda/soda-theme"}
]
