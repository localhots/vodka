module Hren
  module Server
    module Handlers
      module Scaffold
        DEFAULT_PER_PAGE = 20

        def index
          per_page = params[:per_page] || DEFAULT_PER_PAGE
          data = resource_class.paginate(page: params[:page], per_page: per_page)
          respond_with(data: data, meta: { page: data.current_page, per_page: per_page, count: data.count })
        end

        def show
          respond_with(data: resource)
        end

        def create
          respond_with(data: resource_class.create(filtered_params))
        end

        def update
          success = resource.update_attributes(filtered_params)
          response = { data: resource }
          response[:errors] = { update: 'Failed' } unless success
          respond_with(data: response)
        end

        def destroy
          success = resource.destroy
          response = { data: resource }
          response[:errors] = { destroy: 'Failed' } unless success
          respond_with(data: response)
        end
      end
    end
  end
end
