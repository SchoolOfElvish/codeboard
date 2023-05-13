# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Codeboard
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.default_locale = :en
    config.i18n.available_locales = %i[en ru]
    config.active_model.i18n_customize_full_message = true

    routes.default_url_options[:host] = 'localhost:3000'
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # Initialized active_jobs
    config.active_job.queue_adapter = :sidekiq
    config.active_storage.variant_processor = :mini_magick
  end
end
