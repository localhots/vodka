module Vodka
  module Server
    module Handlers
      module Response

        def vodka_response
          @vodka_response ||= Vodka::Server::Response.new
        end

      private

        def respond_with_resource(custom_resource = nil)
          vodka_response.data = custom_resource || resource
          respond!
        end

        def respond_with_collection(resources)
          vodka_response.data = resources
          respond!
        end

        def respond!
          response.headers['X-Response-Id'] = vodka_response.id
          response.headers['X-Response-Signature'] = vodka_response.signature
          return render text: vodka_response.json, status: vodka_response.code, content_type: 'application/json'
        end

        def not_found
          vodka_response.errors[:vodka_error] = '404 Not Found'
          vodka_response.code = 404
          respond!
        end
      end
    end
  end
end
