ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"
require 'vcr'
require 'webmock/minitest'
require 'simplecov'

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
  config.filter_sensitive_data("APP_ID") do
    ENV['APP_ID']
  end

  config.filter_sensitive_data("APP_KEY") do
    ENV['APP_KEY']
  end
end

class ActiveSupport::TestCase
  fixtures :all
end
