module Vodka
  module Server
    class Response
      attr_accessor :id, :code, :success, :data, :presenter, :metadata, :errors

      def initialize
        @code = 200
        @metadata = {}
        @errors = {}
      end

      def json
        metadata[:vodka_action_success] = success unless success.nil?

        if data.nil?
          presented_data = {}
          errors_to_return = errors
        elsif data.is_a?(Array)
          presented_data = data.map{ |item| present(item) }
          errors_to_return = errors
        else
          presented_data = present(data)
          errors_to_return = presented_data.delete(:errors)
        end

        response = {
          data: presented_data,
          metadata: metadata,
          errors: errors_to_return
        }
        # ap response if Rails.env.development? && defined?(AwesomePrint)
        MultiJson.dump(response)
      end

      def present(item)
        return item if item.is_a?(Hash)
        if presenter.nil?
          item.try(:present)
        else
          presenter.new(item).present
        end
      end

      def signature
        Vodka::Server.config.digest.hexdigest([id, Vodka::Server.config.response_secret].join)
      end
    end
  end
end
