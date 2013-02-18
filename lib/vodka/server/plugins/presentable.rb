module Vodka
  module Server
    module Plugins
      module Presentable
        def present_with(*methods)
          define_method 'present_vodka' do
            json = Hash[methods.map{ |method| [method, send(method)] }]
            json[:errors] = errors.messages
            json[:metadata] = {}
            json
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Vodka::Server::Plugins::Presentable) if defined?(ActiveRecord)
MongoMapper::Document.send(:extend, Vodka::Server::Plugins::Presentable) if defined?(MongoMapper)
MongoMapper::EmbeddedDocument.send(:extend, Vodka::Server::Plugins::Presentable) if defined?(MongoMapper)
