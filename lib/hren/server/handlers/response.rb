module Hren
  module Server
    module Handlers
      module Response

        def hren_response
          @hren_response ||= Hren::Server::Response.new
        end

      private

        def respond_with_resource
          hren_response.data = resource
          respond!
        end

        def respond_with_collection(resources)
          hren_response.data = resources
          respond!
        end

        def respond!
          render text: hren_response.json, status: hren_response.code, content_type: 'application/json'
        end

        def respond_with_error(message, code)
          hren_response.errors[:hren_global] = message
          hren_response.code = code
          respond!
        end

        def not_found
          respond_with_error('Not Found', code: 404)
        end
      end
    end
  end
end
