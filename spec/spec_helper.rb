require 'rspec'
require 'simplecov'
require 'coveralls'
require 'active_record'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter "#{File.dirname(__FILE__)}/fake_app"
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Migration.create_table :users

Coveralls.wear!

require "#{File.dirname(__FILE__)}/../lib/zertico"

Dir["#{File.dirname(__FILE__)}/fake_app/config/**/*.rb"].sort.each { |f| require f }
Dir["#{File.dirname(__FILE__)}/fake_app/app/**/*.rb"].sort.each { |f| require f }