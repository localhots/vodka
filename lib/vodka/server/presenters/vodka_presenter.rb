module Vodka
  module Server
    class VodkaPresenter
      attr_accessor :resource

      def initialize(resource)
        @resource = resource
      end

      def present
        raise ::Exception.new("#{self.class.name}#present must be defined!")
      end

      def json(hash)
        hash[:errors] = resource.errors.messages
        hash[:metadata] = {}
        hash
      end
    end
  end
end

VodkaPresenter = Vodka::Server::VodkaPresenter
