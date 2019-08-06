# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://phonesrv-v.newleafsc.net:8498'
    resource '*',
      headers: :any,
      methods: %i(get post put patch delete options head)
  end
end