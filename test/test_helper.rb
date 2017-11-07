require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require 'vcr'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
  config.default_cassette_options = {
    :record => :new_episodes,
    :match_requests_on => [:method, :uri, :body]
  }
  config.filter_sensitive_data("<SLACK_TOKEN>") do
    ENV['SLACK_TOKEN']
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup
    OmniAuth.config.test_mode = true
  end

  def login(merchant, provider)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))
    get auth_callback_path(provider)

  end

  def mock_auth_hash(merchant)
    return {
      provider: merchant.oauth_provider,
      uid: merchant.oauth_uid,
      info: {
        email: merchant.email,
        nickname: merchant.username
      }
    }
  end
end
