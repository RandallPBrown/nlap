require_relative 'boot'

require 'rails/all'
require 'csv'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups(:assets))
module Ops
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.active_support.escape_html_entities_in_json = false

    # TWEAK MORE TO MAKE HTTP WORK FOR STATS
    # config.middleware.insert_before  ActionDispatch::Cookies, Rack::SslEnforcer
    config.middleware.use Rack::SslEnforcer, :except => ['/tools/manufacturer_check', '/tools/validator', '/mfg_warranties'], :except_environments => 'development', strict: true
    # config.middleware.use Rack::SslEnforcer, :except_environments => 'development'

    # for API usage later possibly
    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #      origins '*'
    #      resource '*', :headers => :any, :methods => [:get, :post, :options]
    #    end
    # end

#     LetterOpener.configure do |config|
#   # To overrider the location for message storage.
#   # Default value is <tt>tmp/letter_opener</tt>
#   config.location = Rails.root.join('tmp', 'my_mails')

#   # To render only the message body, without any metadata or extra containers or styling.
#   # Default value is <tt>:default</tt> that renders styled message with showing useful metadata.
#   config.message_template = :light
# end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
