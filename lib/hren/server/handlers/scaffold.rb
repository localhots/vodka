module Hren
  module Server
    module Handlers
      module Scaffold
        DEFAULT_PER_PAGE = 20

        def index
          if defined?(WillPaginate)
            per_page = params[:per_page] || DEFAULT_PER_PAGE
            data = resource_class.paginate(page: params[:page], per_page: per_page)
            hren_response.meta = { page: data.current_page, per_page: per_page, count: data.count }
            respond_with_collection(data)
          else
            respond_with_collection(resource_class.all)
          end
        end

        def show
          respond_with_resource
        end

        def create
          set_resource resource_class.create(filtered_params)
          respond_with_resource
        end

        def update
          hren_response.success = resource.update_attributes(filtered_params)
          respond_with_resource
        end

        def destroy
          hren_response.success = resource.destroy
          respond_with_resource
        end
      end
    end
  end
end
