# -*- encoding: utf-8 -*-
require File.expand_path('../lib/Brightpearl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Damon Allen Davison"]
  gem.email         = ["damon@allolex.net"]
  gem.description   = %q{A Ruby class for working with the Brightpearl API}
  gem.summary       = %q{The Brightpearl gem provides an easy way of talking with the Brightpearl API.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "Brightpearl"
  gem.require_paths = ["lib"]
  gem.version       = Brightpearl::VERSION

  gem.add_dependency 'rest-client'
  gem.add_dependency 'rspec'
end
