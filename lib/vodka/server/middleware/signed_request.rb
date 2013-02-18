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
          env['HTTP_X_REQUEST_SIGNATURE'] == request_signature
        end

        def request_signature
          Digest::SHA512.hexdigest([
            request.scheme, request.host, request.port, request.path,
            env['HTTP_X_REQUEST_ID'], Vodka::Server.config.secret
          ].join)
        end

        def forbidden
          [
            403,
            { 'Content-Type' => 'application/json; charset=utf-8' },
            ['{"data":null,"errors":{"vodka_error":"403 Forbidden"},"metadata":{}}']
          ]
        end
      end
    end
  end
end
