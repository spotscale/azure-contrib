# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'azure/contrib/version'

Gem::Specification.new do |spec|
  spec.name          = "azure-contrib"
  spec.version       = Azure::Contrib::VERSION
  spec.authors       = ["David Michael"]
  spec.email         = ["david.michael@giantmachines.com"]
  spec.summary       = %q{Extensions to the Azure Ruby SDK}
  spec.description   = %q{Extensions to the Azure Ruby SDK - specifically SAS}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "azure"
  spec.add_dependency "hashie"
  spec.add_dependency "addressable"
  spec.add_dependency "celluloid"
end
