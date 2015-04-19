# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragonfly/swift_data_store/version'

Gem::Specification.new do |spec|
  spec.name          = 'dragonfly-swift_data_store'
  spec.version       = Dragonfly::SwiftDataStore::VERSION
  spec.authors       = ['Vincent Hellot']
  spec.email         = ['hellvinz@gmail.com']

  spec.summary       = 'OpenStack Swift data store for Dragonfly'
  spec.description   = 'Data store for storing Dragonfly content (e.g. images) on OpenStack Swift'
  spec.homepage      = 'https://github.com/hellvinz/dragonfly-swift_data_store'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/^spec/) }
  spec.require_paths = ['lib']

  spec.add_dependency 'openstack', '~> 1.1.2'
  spec.add_dependency 'dragonfly', '~> 1.0.7'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~>3.2.0'
  spec.add_development_dependency 'rubocop'
end
