module Hren
  module Server
    module Handlers
      module Scaffold
        DEFAULT_PER_PAGE = 20

        def index
          if params[:hren_special_action] == 'first'
            respond_with_collection([resource_class.first])
          elsif params[:hren_special_action] == 'last'
            respond_with_collection([resource_class.last])
          elsif params[:hren_special_where].present?
            _special_where
          elsif defined?(WillPaginate) && params[:page].present?
            _special_paginate
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
          resource.destroy
          hren_response.success = resource.destroyed?
          respond_with_resource
        end

      private

        def _special_where
          relation = resource_class
          conditions = MultiJson.load(params[:hren_special_where])
          conditions.each do |condition|
            if condition.is_a?(Hash)
              relation = relation.where(condition)
            else
              relation = relation.where(*condition)
            end
          end
          respond_with_collection(relation.all)
        end

        def _special_paginate
          per_page = params[:per_page] || DEFAULT_PER_PAGE
          data = resource_class.paginate(page: params[:page], per_page: per_page).all
          hren_response.metadata = { page: data.current_page, per_page: per_page, total: resource_class.count }
          respond_with_collection(data)
        end
      end
    end
  end
end
