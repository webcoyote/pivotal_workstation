default['sublime_text']['osx'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.dmg',
  'checksum' => '906e71e19ae5321f80e7cf42eab8355146d8f2c3fd55be1f7fe5c62c57165add'
}

default['sublime_text']['debian'] = {
  'url' => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2',
  'checksum' => '01baed30d66432e30002a309ff0393967be1daba5cce653e43bba6bd6c38ab84'
}

default["sublime_text_packages"] = [
  {"name" => "Theme - Soda", "source" => "https://github.com/buymeasoda/soda-theme"}
]
