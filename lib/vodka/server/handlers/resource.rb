module Vodka
  module Server
    module Handlers
      module Resource
      private

        def resource
          @resource ||= extract_resource
        end

        def extract_resource
          return unless params.has_key?(:id)

          new_resource = resource_class.find_by_id(params[:id])
          vodka_response.success = false if new_resource.nil?

          new_resource
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
