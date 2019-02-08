require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Projects
  class Application < Rails::Application
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        controller_specs: false,
        helper_specs: false,
        routing_specs: false
    end
  end
end
