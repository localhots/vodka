# encoding: utf-8
require File.expand_path('../lib/hren/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Gregory Eremin']
  gem.email         = ['magnolia_fan@me.com']
  gem.description   = 'A set of tools to make communication between two Rails apps easier'
  gem.summary       = 'This gem uses gem Her to commicate to some RESTful app. It extends functionality of Her and adds some guidelines for both apps.'
  gem.homepage      = 'https://github.com/magnolia-fan/hren'

  gem.files         = `git ls-files`.split($\)
  # gem.test_files    = gem.files.grep(%r{^spec/})
  gem.name          = 'hren'
  gem.require_paths = ['lib']
  gem.version       = Hren::VERSION

  gem.add_runtime_dependency 'her', '~> 0.4'
  gem.add_runtime_dependency 'multi_json', '~> 1.6.1'

  gem.add_development_dependency 'rails', '~> 3.2.12'
  gem.add_development_dependency 'will_paginate', '~> 3.0.4'
  gem.add_development_dependency 'sqlite3', '~> 1.3.7'
  gem.add_development_dependency 'thin', '~> 1.5.0'

  gem.add_development_dependency 'rspec', '~> 2.12.0'
end
