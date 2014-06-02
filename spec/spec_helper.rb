require 'rspec'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter "#{File.dirname(__FILE__)}/fake_app"
end

Coveralls.wear!

require "#{File.dirname(__FILE__)}/../lib/zertico"

Dir["#{File.dirname(__FILE__)}/fake_app/**/*.rb"].sort.each { |f| require f }