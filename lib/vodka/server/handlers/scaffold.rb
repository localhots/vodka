module Vodka
  module Server
    module Handlers
      module Scaffold
        def index
          if params[:vodka_special_action] == 'first'
            resources = [resource_class.first]
          elsif params[:vodka_special_action] == 'last'
            resources = [resource_class.last]
          elsif params[:vodka_special_where].present?
            resources = vodka_special_where
          elsif params[:page].present? && defined?(::WillPaginate)
            resources = vodka_special_paginate
          else
            resources = resource_class.all
          end

          respond_with_collection(resources)
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
          resource.destroy
          vodka_response.success = resource.destroyed?
          respond_with_resource
        end

      private

        def vodka_special_where
          relation = resource_class
          conditions = MultiJson.load(params[:vodka_special_where])
          conditions.each do |condition|
            if condition.is_a?(Hash)
              relation = relation.where(condition)
            else
              relation = relation.where(*condition)
            end
          end
          relation.all
        end

        def vodka_special_paginate
          data = resource_class.paginate(page: params[:page], per_page: params[:per_page]).all
          vodka_response.metadata = { page: data.current_page, per_page: data.per_page, total: resource_class.count }
          data
        end
      end
    end
  end
end
