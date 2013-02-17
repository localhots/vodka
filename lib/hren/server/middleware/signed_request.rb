module Hren
  module Server
    module Middleware
      class SignedRequest
        attr_reader :app, :request

        def initialize(app, options = {})
          @app, @options = app, options
        end

        def call(env)
          @request = Rack::Request.new(env)
          raise ActionController::Forbidden unless request_signature_valid?
          app.call(env)
        end

        def request_signature_valid?
          request.headers['X-Request-Signature'] == request_signature
        end

        def request_signature
          Digest::SHA512.hexdigest([
            request.scheme, request.host, request.port, request.path,
            request.headers['X-Request-Id'], Hren.config.secret
          ].join)
        end
      end
    end
  end
end
