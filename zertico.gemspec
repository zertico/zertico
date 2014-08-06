# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zertico/version'

Gem::Specification.new do |gem|
  gem.name          = "zertico"
  gem.version       = Zertico::VERSION
  gem.authors       = ['Paulo Henrique Lopes Ribeiro']
  gem.email         = %w(plribeiro3000@gmail.com)
  gem.description   = %q{Collection of Patterns and Tools to increase development speed}
  gem.summary       = %q{Common Patterns used by Zertico}

  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|gemfiles)/})
  gem.require_paths = %w(lib)

  gem.add_runtime_dependency 'rails', '>= 3.1.0'
  gem.add_development_dependency 'coveralls' if RUBY_VERSION.to_f >= 1.9
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-rails'

  if RUBY_PLATFORM == 'java'
    gem.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
  else
    gem.add_development_dependency 'sqlite3'
  end
end