require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NatDynamics
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es, :en]
    config.time_zone = 'Santiago'
    config.active_record.default_timezone = :local


    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    config.autoload_paths << "#{Rails.root}/lib"
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
  end
end
