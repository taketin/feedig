# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feedig/version'

Gem::Specification.new do |spec|
  spec.name          = "feedig"
  spec.version       = Feedig::VERSION
  spec.authors       = ["taketin"]
  spec.email         = ["tksthdnr@gmail.com"]
  spec.summary       = %q{feedig is Feed IRC Gateway. feedig is forked from agig.rb, and contained net-irc gems.}
  spec.description   = %q{Feed IRC Gateway}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency 'net-irc'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'feedzirra', "~> 0.7.1"
end
