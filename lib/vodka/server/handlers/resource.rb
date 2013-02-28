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

          new_resource = begin
            resource_class.find(params[:id])
          rescue
            nil
          end
          vodka_response.success = false if new_resource.nil?

          new_resource
        end

        def filtered_params
          params.permit(*(resource_class.attribute_names - ['id']).map(&:to_sym))
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
