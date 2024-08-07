# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Moon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    %w[
      vendor/assets/bower_components
      vendor/assets/bower_components/bootstrap/dist/css
      vendor/assets/bower_components/bootstrap/dist/js
      vendor/assets/bower_components/select2
      vendor/assets/bower_components/bootstrap-sass/assets/fonts/bootstrap
      vendor/assets/bower_components/bootstrap-sass/assets/javascripts
    ].each do |path|
      config.assets.paths << Rails.root.join(*path.split('/'))
    end
    # config.assets.precompile += [/.*?\.(eot|svg|ttf|woff)$/]
    # config.assets.precompile += [/.*?\.(png)$/]
  end
end
