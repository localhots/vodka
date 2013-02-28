require 'rails' unless defined?(::Rails)

module Vodka
  module Server
    class Railtie < ::Rails::Railtie
      initializer 'vodka.inject_middleware' do |app|
        app.config.middleware.use 'Vodka::Server::Middleware::SignedRequest'
      end

      initializer 'vodka.inject_presenter' do |app|
        if defined?(ActiveRecord)
          ActiveRecord::Base.send(:include, Vodka::Server::Plugins::Presentable)
        end
        if defined?(MongoMapper)
          MongoMapper::Document.send(:include, Vodka::Server::Plugins::Presentable)
          MongoMapper::EmbeddedDocument.send(:include, Vodka::Server::Plugins::Presentable)
        end
        if defined?(Mongoid)
          Mongoid::Document.send(:include, Vodka::Server::Plugins::Presentable)
        end
      end
    end
  end
end
