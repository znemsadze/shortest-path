# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shortest/path/version'

Gem::Specification.new do |spec|
  spec.name          = "shortest-path"
  spec.version       = Shortest::Path::VERSION
  spec.authors       = ["Dimitri Kurashvili"]
  spec.email         = ["dimakura@gmail.com"]
  spec.summary       = %q{finding shortest path}
  spec.description   = %q{ruby gem for finding shortest path}
  spec.homepage      = "http://github.com/georgian-se/shortest-path"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "algorithms"
end
