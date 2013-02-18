require 'rails' unless defined?(::Rails)

module Vodka
  module Server
    class Railtie < ::Rails::Railtie
      initializer 'vodka.inject_middleware' do |app|
        app.config.middleware.use 'Vodka::Server::Middleware::SignedRequest'
      end
    end
  end
end
