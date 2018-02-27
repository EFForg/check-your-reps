require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CheckYourReps
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Autoload the contents of lib.
    config.autoload_paths += %W(#{config.root}/lib)
    config.eager_load_paths += %W(#{config.root}/lib)

    config.twitter_related = Rails.application.secrets.twitter_related ? Rails.application.secrets.twitter_related.split(" ") : []

    # Support local fonts
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
