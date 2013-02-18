module Vodka
  module Client
    module Middleware
      class SignedRequest < Faraday::Middleware
        attr_reader :app, :env

        def initialize(app, options = {})
          @app = app
        end

        def call(_env)
          @env = _env

          env[:request_headers]['X-Request-Id'] = request_id
          env[:request_headers]['X-Request-Signature'] = request_signature
          env[:request_headers]['X-Response-Locale'] = I18n.locale.to_s if defined?(I18n)

          @app.call(env)
        end

        def request_id
          @request_id ||= [Time.now.to_i, (rand * 100_000_000).to_i].join(?_)
        end

        def request_signature
          Digest::SHA512.hexdigest([
            env[:url].scheme, env[:url].host, env[:url].port, env[:url].path,
            request_id, Vodka::Client.config.secret
          ].join)
        end
      end
    end
  end
end
