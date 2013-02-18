module Hren
  module Server
    class Response
      attr_accessor :code, :success, :data, :metadata, :errors

      def initialize
        @code = 200
        @metadata = {}
        @errors = {}
      end

      def json
        metadata[:hren_action_success] = success unless success.nil?

        if data.nil?
          presented_data = nil
          errors_to_return = errors
        elsif data.is_a?(Array)
          presented_data = data.map(&:present_hren)
          errors_to_return = errors
        else
          presented_data = data.present_hren
          errors_to_return = presented_data.delete(:errors)
        end

        MultiJson.dump(
          data: presented_data,
          metadata: metadata,
          errors: errors_to_return
        )
      end
    end
  end
end
