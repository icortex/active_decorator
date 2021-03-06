$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
# load Rails first
require 'rails'
require 'active_decorator'
# needs to load the app before loading rspec/rails => capybara
require 'fake_app/fake_app'
require 'rspec/rails'
require 'mongoid'
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'authors'
  end
  config.before :each do
    Book.delete_all
    Author.delete_all
    Movie.delete_all
    Mongoid::Config.purge!
  end

  Mongoid.configure do |config|
    config.connect_to('active_decorator_test')
  end
end
