module Hren
  module Server
    module Handlers
      module Response

        def hren_response
          @hren_response ||= Hren::Server::Response.new
        end

      private

        def respond_with_resource(custom_resource = nil)
          hren_response.data = custom_resource || resource
          respond!
        end

        def respond_with_collection(resources)
          hren_response.data = resources
          respond!
        end

        def respond!
          return render text: hren_response.json, status: hren_response.code, content_type: 'application/json'
        end

        def not_found
          hren_response.errors[:hren_error] = '404 Not Found'
          hren_response.code = 404
          respond!
        end
      end
    end
  end
end
