module Hren
  module Client
    module Middleware
      class ErrorAware < Faraday::Response::Middleware
        def on_complete(env)
          env[:body] = MultiJson.load(env[:body]) unless env[:body].is_a?(Hash)
          return unless env[:body][:errors].present? && env[:body][:errors][:hren_error].present?

          case env[:body][:errors][:hren_error]
          when ForbiddenException::MESSAGE
            raise ForbiddenException.new
          when NotFoundException::MESSAGE
            raise NotFoundException.new
          else
            raise Exception.new(env[:body][:errors][:hren_error])
          end
        end
      end
    end
  end
end
