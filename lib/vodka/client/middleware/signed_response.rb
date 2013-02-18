module Vodka
  module Client
    module Middleware
      class SignedResponse < Faraday::Response::Middleware
        attr_reader :env

        def on_complete(env)
          @env = env
          raise SecurityException.new('Response ID mismatch') unless ids_match?
          raise SecurityException.new('Invalid response signature') unless signature_valid?
        end

        def ids_match?
          request_id == response_id
        end

        def signature_valid?
          response_signature == expected_response_signature
        end

        def request_id
          env[:request_headers]['X-Request-Id']
        end

        def response_id
          env[:response_headers]['x-response-id']
        end

        def response_signature
          env[:response_headers]['x-response-signature']
        end

        def expected_response_signature
          Digest::SHA512.hexdigest([request_id, Vodka::Client.config.response_secret].join)
        end
      end
    end
  end
end
