# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'union_find/version'

Gem::Specification.new do |spec|
  spec.name          = "union_find"
  spec.version       = UnionFind::VERSION
  spec.authors       = ["Michael Imstepf"]
  spec.email         = ["michael.imstepf@gmail.com"]
  spec.summary       = %q{Weighted quick-union algorithm with path compression.}
  spec.description   = %q{Union Find is an algorithm that uses a disjoint-set data structure. It allows us to efficiently connect any items of a given list and to efficiently check whether two items of this list are connected (any degree of separation) or not.}
  spec.homepage      = "https://github.com/michaelimstepf/union-find"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
