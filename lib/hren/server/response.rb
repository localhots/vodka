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
        elsif data.is_a?(Array)
          presented_data = data.map(&:present_hren)
        else
          presented_data = data.present_hren
          errors = presented_data.delete(:errors)
          metadata = presented_data.delete(:metadata)
        end

        MultiJson.dump(
          data: presented_data,
          metadata: metadata,
          errors: errors
        )
      end
    end
  end
end
