require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "bc069af4312969844bf29ecb3e46e35cc15cdcf7d38f2cdf24e4b3934f26f77e"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
ActiveSupport.on_load(:active_record) do
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations
end
