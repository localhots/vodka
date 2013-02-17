module Hren
  module Server
    module Handlers
      module Response
      private

        def respond_with(parameters)
          response = {}
          data = {
            data: parameters[:data] || {},
            errors: parameters[:errors] || {},
            metadata: parameters[:meta] || {}
          }
          response[:content_type] = parameters[:content_type] || 'application/json'
          response[:status] = parameters[:status] || 200
          response[:text] = MultiJson.dump(data)

          render response
        end

        def respond_with_error(message, code)
          respond_with({error: message}, status: code)
        end

        def not_found
          respond_with(data: {})
        end
      end
    end
  end
end
