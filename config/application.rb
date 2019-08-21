require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FunnyVideos
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |g|
      g.helper false
      g.stylesheet_engine :sass
      g.template_engine :slim
      g.test_framework :rspec, controller_specs: false, view_specs: false, helper_specs: false, request_specs: false
      g.factory_bot dir: 'spec/support/factories/'
    end
  end
end
