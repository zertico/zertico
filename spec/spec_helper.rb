require "rspec"
require "coveralls"

Coveralls.wear!

require "#{File.dirname(__FILE__)}/../lib/zertico"

Dir["#{File.dirname(__FILE__)}/fake_app/**/*.rb"].sort.each { |f| require f }