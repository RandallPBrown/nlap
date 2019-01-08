require_relative 'boot'

require 'rails/all'
require 'csv'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Ops
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
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
