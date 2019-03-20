require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Zhuye
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.i18n.fallbacks = [I18n.default_locale]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**','*.{rb,yml}').to_s]
    config.i18n.default_locale = :zh
    config.encoding = 'utf-8' 
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => :any #[:get, :post, :options]
      end
    end
  end
end
