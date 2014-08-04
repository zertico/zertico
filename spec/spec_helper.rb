require 'rspec'
require 'active_record'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Migration.create_table :users

if ENV['COVERAGE']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter "#{File.dirname(__FILE__)}/fake_app"
  end

  Coveralls.wear!
end

require "#{File.dirname(__FILE__)}/../lib/zertico"

Dir["#{File.dirname(__FILE__)}/fake_app/config/**/*.rb"].sort.each { |f| require f }
Dir["#{File.dirname(__FILE__)}/fake_app/app/**/*.rb"].sort.each { |f| require f }