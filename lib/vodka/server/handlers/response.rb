module Vodka
  module Server
    module Handlers
      module Response
        def vodka_response
          @vodka_response ||= Vodka::Server::Response.new
        end

      private

        def respond_with_resource(custom_resource = nil, presenter = nil)
          vodka_response.data = custom_resource || resource
          vodka_response.presenter = presenter unless presenter.nil?
          respond!
        end

        def respond_with_collection(resources, presenter = nil)
          vodka_response.data = resources.to_a
          vodka_response.presenter = presenter unless presenter.nil?
          respond!
        end

        def respond!
          if Vodka::Server.config.perform_request_signing
            response.headers['X-Response-Id'] = vodka_response.id
            response.headers['X-Response-Signature'] = vodka_response.signature
          end

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
