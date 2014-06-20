require 'simplecov'
SimpleCov.start do
  add_filter 'test'
  command_name 'Mintest'
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "minitest/autorun"
require 'factory_girl'


Rails.backtrace_cleaner.remove_silencers!

FactoryGirl.factories.clear
FactoryGirl.definition_file_paths = [File.expand_path("../factories/", __FILE__)]
FactoryGirl.find_definitions


# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

class ActionDispatch::Routing::RouteSet
  def default_url_options(options={})
    { :host => "test.host" }.merge options
  end
end
