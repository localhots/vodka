module Vodka
  module Server
    module Handlers
      module Scaffold
        def index
          if params[:vodka_special_action] == 'first'
            return respond_with_collection([resource_class.first])
          elsif params[:vodka_special_action] == 'last'
            return respond_with_collection([resource_class.last])
          end

          @relation = resource_class
          vodka_apply_relation_where_conditions!
          vodka_apply_where_conditions!
          vodka_apply_pagination_conditions!

          respond_with_collection(@relation.all)
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

        def vodka_apply_relation_where_conditions!
          params.each do |key, value|
            if key.to_s.end_with?('_id')
              model = key.slice(0, key.length - 3).classify.constantize
              value = value.to_i if model.ancestors.include?(ActiveRecord::Base)
              @relation = @relation.where(key => value)
            end
          end
        end

        def vodka_apply_where_conditions!
          return unless params[:vodka_special_where].present?

          MultiJson.load(params[:vodka_special_where]).each do |condition|
            if condition.is_a?(Hash)
              @relation = @relation.where(condition)
            else
              @relation = @relation.where(*condition)
            end
          end
        end

        def vodka_apply_pagination_conditions!
          return unless params[:page].present? && params[:per_page].present?

          page = params[:page].to_i.abs
          per_page = params[:per_page].to_i.abs

          @relation = @relation.offset((page - 1) * per_page).limit(per_page)
          vodka_response.metadata = { current_page: page, per_page: per_page, total_entries: resource_class.count }
        end
      end
    end
  end
end
