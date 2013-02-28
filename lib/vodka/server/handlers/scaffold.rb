module Vodka
  module Server
    module Handlers
      module Scaffold
        def index
          relation = Vodka::Server::Relation.new(resource_class, params)
          vodka_response.metadata.merge!(relation.metadata)
          respond_with_collection(relation.data)
        end

        def show
          respond_with_resource
        end

        def create
          respond_with_resource(resource_class.create(filtered_params))
        end

        def update
          vodka_response.success = resource.update_attributes(filtered_params)
          respond_with_resource
        end

        def destroy
          method = params.has_key?(:soft) ? :delete : :destroy
          resource.send(method)
          vodka_response.success = resource.destroyed?
          respond_with_resource
        end
      end
    end
  end
end
