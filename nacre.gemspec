# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nacre/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Damon Allen Davison"]
  gem.email         = ["damon@allolex.net"]
  gem.description   = %q{A Ruby class for working with the Brightpearl API}
  gem.summary       = %q{The Nacre gem provides an easy way of talking with the Brightpearl API.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nacre"
  gem.require_paths = ["lib"]
  gem.version       = Nacre::VERSION

  gem.add_dependency 'faraday'
  gem.add_dependency 'json'
  gem.add_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'pry'
end
