source 'https://rubygems.org'
ruby '3.1.2'


git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

gem 'pg', '~> 1.4.3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem "strip_attributes"

# Last attempt at getting agent stats in portal for awhile
gem 'rack-ssl-enforcer'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'geocoder'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'httparty'
gem 'ruby_kml'
# gem 'rack-cors'

gem 'devise'
# gem "paranoia", "~> 2.2"
# gem 'paranoia_uniqueness_validator', '3.1.0'

# Bootstrap css library
gem 'bootstrap'
gem 'popper_js'
gem 'toastr-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-select-rails'
gem 'pg_search'
gem "will_paginate", "~> 3.1.1"
#gem 'activeadmin'
#gem "active_admin_import"
gem "simple_calendar", "~> 2.0"
# pdf to create forms
gem 'wicked_pdf', '~> 1.1'
gem 'wkhtmltopdf-binary'
gem 'wkhtmltopdf-heroku', '2.12.5.0'
# Realtime updates
gem 'pusher'
gem 'figaro'
# testing mailers
gem "letter_opener", :group => :development
# generate error reports
gem 'bullet', group: 'development'
# Set agent roles
gem 'rolify'
# Edit forms in line
gem 'best_in_place', '~> 3.0.1'
gem 'smarter_csv'
gem 'net-smtp', require: false

gem 'kiso_themes', '~> 1.0', '>= 1.0.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'spring-commands-rspec'
  gem 'guard', '>= 2.14.1', require: false
  gem 'guard-rspec', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'jquery-rails'