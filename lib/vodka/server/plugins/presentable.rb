module Vodka
  module Server
    module Plugins
      module Presentable
        extend ActiveSupport::Concern

        def present
          presenter_class = if self.class.class_variable_defined?(:@@presenter)
            self.class.class_variable_get(:@@presenter)
          else
            Object.const_get(:"#{self.class.name}Presenter")
          end
          presenter_class.new(self).present
        end

        module ClassMethods
          def present_with(klass)
            class_variable_set(:@@presenter, klass)
          end
        end
      end
    end
  end
end

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
