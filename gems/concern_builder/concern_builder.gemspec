# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'concern_builder/version'

Gem::Specification.new do |spec|
  spec.name          = 'concern_builder'
  spec.version       = ConcernBuilder::VERSION
  spec.authors       = ['DarthJee']
  spec.email         = ['darthjee@gmail.com']
  spec.summary       = 'Concern Builder'
  spec.description   = spec.description
  spec.homepage      = 'https://github.com/darthjee/concern_builder'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'simplecov'
end
