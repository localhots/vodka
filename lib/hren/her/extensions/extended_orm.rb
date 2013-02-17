module Hren
  module Her
    module Extensions
      module ExtendedOrm
        extend ActiveSupport::Concern

        module ClassMethods
          def find(*ids)
            response = super(*ids)
            return response if response.is_a?(Array)
            return nil if response.data_empty?
            response
          end

          def create!(*args)
            resource = create(*args)
            raise Exception.new([resource.errors.keys.first, resource.errors.values.first].join(' ')) unless resource.errors.empty?
            resource
          end
        end

        def update_attributes(params)
          params.each do |attribute, value|
            send(:"#{attribute}=", value)
          end
          save
        end

        def update_attributes!(params)
          update_attributes(params)
          raise Exception.new([errors.keys.first, errors.values.first].join(' ')) unless errors.empty?
          self
        end

        def update_attribute(attribute, value)
          update_attributes(attribute => value)
        end

        def update_attribute!(attribute, value)
          update_attributes!(attribute => value)
        end

        def destroy!
          destroy(params)
          raise_exception_if_present!
          self
        end
      end
    end
  end
end

Her::Model.send(:include, Hren::Her::Extensions::ExtendedOrm)
