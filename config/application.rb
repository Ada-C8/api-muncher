require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module ApiMuncher
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :minitest, spec: true
      g.javascript_engine :js
    end
    config.load_defaults 5.1
    config.autoload_paths << Rails.root.join('lib')
  end
end
