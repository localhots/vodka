# encoding: utf-8
require File.expand_path('../lib/vodka/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Gregory Eremin']
  gem.email         = ['magnolia_fan@me.com']
  gem.description   = 'A set of tools to make communication between two Rails apps easier'
  gem.summary       = 'This gem uses gem Her to commicate to some RESTful app. It extends functionality of Her and adds some guidelines for both apps.'
  gem.homepage      = 'https://github.com/magnolia-fan/vodka'

  gem.files         = `git ls-files`.split($\)
  # gem.test_files    = gem.files.grep(%r{^spec/})
  gem.name          = 'vodka'
  gem.require_paths = ['lib']
  gem.version       = Vodka::VERSION

  gem.add_runtime_dependency 'extended_her', '~> 0.5'
  gem.add_runtime_dependency 'multi_json', '~> 1.6.1'
  gem.add_development_dependency 'rspec', '~> 2.12.0'
  gem.add_development_dependency 'i18n', '~> 0.6.1'
end
