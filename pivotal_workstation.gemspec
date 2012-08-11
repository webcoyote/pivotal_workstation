# # -*- encoding: utf-8 -*-
# $:.push File.expand_path("../lib", __FILE__)
# require "pivotal_workstation_cookbook"
# 
# Gem::Specification.new do |s|
#   s.name        = "pivotal_workstation_cookbook"
#   s.version     = PivotalWorkstationCookbook::VERSION
#   s.authors     = ["Matthew Kocher"]
#   s.email       = ["kocher@gmail.com"]
#   s.homepage    = "https://github.com/mkocher/pivotal_workstation_cookbook"
#   s.summary     = %q{The pivotal_workstation OSX Chef cookbook}
#   s.description = %q{Packaged as a gem for use with soloist.}
# 
#   s.files         = `git ls-files`.split("\n")
#   s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
#   s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
#   s.require_path = "lib"
# 
#   s.add_dependency "dmg_cookbook"
# end


class MetadataParser
  attr_accessor :metadata

  def initialize
    @metadata = {}
    @dependencies = []
  end

  def method_missing(method, value)
    metadata[method] = value
  end

  def depends(dependency, version=">= 0.0.0")
    @dependencies << dependency
  end

  def gemspec
    Gem::Specification.new do |s|
      p "hello"
      s.name        = "pivotal_workstation_cookbook"
      s.version     = metadata['version']
      s.authors     = [metadata['maintainer']]
      s.email       = [metadata['maintainer_email']]
      s.homepage    = "https://github.com/mkocher/pivotal_workstation_cookbook"
      s.summary     = metadata['description']
      s.description = metadata['long_description']

      s.files         = `git ls-files`.split("\n")
      s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
      s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
      s.require_path = "lib"

      @dependencies.each do |depency, version|
        s.add_dependency dependency, version
      end
    end
  end
end

parser = MetadataParser.new
parser.instance_eval(File.read(File.expand_path("../metadata.rb", __FILE__)))
gemspec = parser.gemspec
p gemspec.name