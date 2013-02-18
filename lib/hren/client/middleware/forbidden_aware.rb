module Hren
  module Client
    module Middleware
      class ForbiddenAware < Faraday::Response::Middleware
        def on_complete(env)
          env[:body] = MultiJson.load(env[:body]) unless env[:body].is_a?(Hash)
          if env[:body][:errors].present? && env[:body][:errors][:hren_error] == '403 Forbidden'
            raise Exception.new('403 Forbidden')
          end
        end
      end
    end
  end
end
