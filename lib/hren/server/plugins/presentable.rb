module Hren
  module Server
    module Plugins
      module Presentable
        def present_with(*methods)
          define_method 'present_hren' do
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

ActiveRecord::Base.send(:extend, Hren::Server::Plugins::Presentable) if defined?(ActiveRecord)
MongoMapper::Document.send(:extend, Hren::Server::Plugins::Presentable) if defined?(MongoMapper)
MongoMapper::EmbeddedDocument.send(:extend, Hren::Server::Plugins::Presentable) if defined?(MongoMapper)
