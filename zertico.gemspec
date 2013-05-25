# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zertico/version'

Gem::Specification.new do |gem|
  gem.name          = "zertico"
  gem.version       = Zertico::VERSION
  gem.authors       = ["Paulo Henrique Lopes Ribeiro"]
  gem.email         = ["plribeiro3000@gmail.com"]
  gem.description   = %q{Easy Rails development using the Zertico Way}
  gem.summary       = %q{Models and patterns used by Zertico}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "rails"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "coveralls"
end
