module Hren
  module Her
    module Extensions
      module ExtendedOrm
        extend ActiveSupport::Concern

        module ClassMethods
          def create!(*args)
            resource = create(*args)
            raise Hren::Client::ResourceException.new([resource.errors.keys.first, resource.errors.values.first].join(' ')) unless resource.errors.empty?
            resource
          end

          def first
            resources = all(hren_special_action: 'first')
            resource = resources.first
            resource.errors = resources.errors
            resource.metadata = resources.metadata
            resource
          end

          def last
            resources = all(hren_special_action: 'last')
            resource = resources.first
            resource.errors = resources.errors
            resource.metadata = resources.metadata
            resource
          end

          def where(*args)
            @where_conditions ||= []
            @where_conditions << args
            self
          end

          def all(params = {})
            unless @where_conditions.nil?
              params[:hren_special_where] = MultiJson.dump(@where_conditions)
              @where_conditions = nil
            end
            super(params)
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
          raise Hren::Client::ResourceException.new([errors.keys.first, errors.values.first].join(' ')) unless errors.empty?
          self
        end

        def update_attribute(attribute, value)
          update_attributes(attribute => value)
        end

        def update_attribute!(attribute, value)
          update_attributes!(attribute => value)
        end

        def destroy!
          destroy
          raise Hren::Client::FailedActionException.new('Destroy failed') if metadata[:hren_action_success] == false
          self
        end

        def delete
          destroy
        end

        def delete!
          destroy!
        end
      end
    end
  end
end

Her::Model.send(:include, Hren::Her::Extensions::ExtendedOrm)
