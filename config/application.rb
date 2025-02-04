# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PostcodeChecker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.autoload_paths << Rails.root.join('lib')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.before_configuration do
      env_file = Rails.root.join('config/env.yml')
      if File.exist?(env_file)
        require 'erb'
        all_vars = YAML.safe_load(ERB.new(IO.read(env_file)).result) || {}
        env_vars = all_vars[Rails.env]
        ENV.merge! env_vars if env_vars
      end
    end
  end
end
