require 'simplecov'
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "minitest/rails"
require 'vcr'
require 'webmock/minitest'
require "minitest/reporters"



Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes' # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body] # The http method, URI and body of a request all need to match
  }
  # Don't leave our Slack token lying around in a cassette file.
  config.filter_sensitive_data("<EDAMAM_KEY>") do
    ENV['EDAMAM_KEY']
  end
  config.filter_sensitive_data("<Edamam_App_ID>") do
    ENV["Edamam_App_ID"]
  end
end


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
