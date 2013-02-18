module Vodka
  module Server
    module Middleware
      class SignedRequest
        attr_reader :app, :env, :request

        def initialize(app, options = {})
          @app, @options = app, options
        end

        def call(env)
          @env = env
          @request = Rack::Request.new(env)

          request_signature_valid? ? app.call(env) : forbidden
        end

        def request_signature_valid?
          request_signature == expected_request_signature
        end

        def request_id
          env['HTTP_X_REQUEST_ID']
        end

        def request_signature
          env['HTTP_X_REQUEST_SIGNATURE']
        end

        def expected_request_signature
          Digest::SHA512.hexdigest([request_id, Vodka::Server.config.request_secret].join)
        end

        def response_signature
          Digest::SHA512.hexdigest([request_id, Vodka::Server.config.response_secret].join)
        end

        def forbidden
          headers = {
            'Content-Type'         => 'application/json; charset=utf-8',
            'X-Response-Id'        => request_id,
            'X-Response-Signature' => response_signature
          }
          data = {
            data: nil,
            errors: {
              vodka_error: '403 Forbidden'
            },
            metadata: {}
          }
          [403, headers, [MultiJson.dump(data)]]
        end
      end
    end
  end
end
