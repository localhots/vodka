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

  gem.add_runtime_dependency 'her'
  gem.add_runtime_dependency 'faraday'
  gem.add_runtime_dependency 'multi_json'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'awesome_print'
end
