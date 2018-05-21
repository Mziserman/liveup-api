require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Liveup
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.action_cable.url = [/ws:\/\/*/, /wss:\/\/*/]
    config.action_cable.disable_request_forgery_protection = true
    config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
