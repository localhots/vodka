module Hren
  module Server
    class Railtie < Rails::Railtie
      initializer 'hren.inject_middleware' do |app|
        require 'hren/server/middleware/signed_request'
        require 'hren/server/handlers/resource'
        require 'hren/server/handlers/response'
        require 'hren/server/handlers/scaffold'
        require 'hren/server/controllers/hren_controller'
        require 'hren/server/plugins/presentable'
        require 'hren/server/response'

        app.middleware.use Hren::Server::Middleware::SignedRequest
      end
    end
  end
end
