# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Moon
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('app', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'pt-BR'
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'select2')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'bootstrap-sass', 'assets', 'fonts', 'bootstrap')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'bootstrap-sass', 'assets', 'javascripts')

    config.assets.precompile += [/.*?\.(eot|svg|ttf|woff)$/]
    config.assets.precompile += [/.*?\.(png)$/]
  end
end