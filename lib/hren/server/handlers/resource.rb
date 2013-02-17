module Hren
  module Server
    module Handlers
      module Resource
      private

        def resource
          @resource ||= params.has_key?(:id) ? resource_class.find_by_id(params[:id]) : nil
        end

        def set_resource(resource)
          @resource = resource
        end

        def filtered_params
          params.slice(*resource_class.accessible_attributes.to_a)
        end

        # Resource magick

        def resource_name
          self.class.name.demodulize.underscore.gsub('_controller', '').singularize
        end

        def resource_class
          resource_name.camelcase.constantize
        end
      end
    end
  end
end
