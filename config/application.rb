require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FlowerApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # タイムゾーンを日本語に設定
    # config.time_zone = "Asia/Tokyo"
    # デフォルトのロケールを日本に設定
    config.i18n.default_locale = :ja
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
