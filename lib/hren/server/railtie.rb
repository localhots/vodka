require 'rails' unless defined?(::Rails)

module Hren
  module Server
    class Railtie < ::Rails::Railtie
      initializer 'hren.inject_middleware' do |app|
        app.config.middleware.use 'Hren::Server::Middleware::SignedRequest'
      end
    end
  end
end
