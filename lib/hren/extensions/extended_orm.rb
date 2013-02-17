module Hren
  module Extensions
    module ExtendedOrm
      def find(*ids)
        response = super(*ids)
        return response if response.is_a?(Array)
        return nil if response.data_empty?
        response
      end

      def update_attributes(params)
        params.each do |attribute, value|
          send(:"#{attribute}=", value)
        end
        save
      end

      def update_attributes!(params)
        update_attributes(params)
        raise_exception_if_present!
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

      alias_method :where, :all
      alias_method :delete, :destroy
      alias_method :delete!, :destroy!

    private

      def data_empty?
        data.data.empty?
      end

      def raise_exception_if_present!
        if metadata.has_key?(:exception)
          klass = metadata[:exception][:class]
          message = metadata[:exception][:message]
          raise klass.new(message)
        end
      end
    end
  end
end

Her::Model.send(:include, Hren::Extensions::ExtendedOrm)
