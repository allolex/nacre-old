# -*- encoding: utf-8 -*-
require File.expand_path('../lib/Brightpearl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Damon Allen Davison"]
  gem.email         = ["damon@allolex.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
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
