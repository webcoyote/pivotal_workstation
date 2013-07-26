node.default["sublime_text"] = {
  :download_url => "http://c758482.r82.cf2.rackcdn.com",
  :version => "2.0.2",
  :checksum => {
    :linux => '01baed30d66432e30002a309ff0393967be1daba5cce653e43bba6bd6c38ab84',
    :osx => '906e71e19ae5321f80e7cf42eab8355146d8f2c3fd55be1f7fe5c62c57165add',
  }
}

# Sort alphabetically by name
node.default["sublime_text_packages"] = [
  {"name" => "Theme - Soda", "source" => "https://github.com/buymeasoda/soda-theme"}
]
