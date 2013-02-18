module Vodka
  module Her
    module Extensions
      module ExtendedOrm
        extend ActiveSupport::Concern

        module ClassMethods
          def create!(*args)
            resource = create(*args)
            unless resource.errors.empty?
              error = [resource.errors.keys.first, resource.errors.values.first].join(' ')
              raise Vodka::Client::ResourceException.new(error)
            end

            resource
          end

          def first
            resources = all(vodka_special_action: 'first')
            resource = resources.first
            resource.errors = resources.errors
            resource.metadata = resources.metadata
            resource
          end

          def last
            resources = all(vodka_special_action: 'last')
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
              params[:vodka_special_where] = MultiJson.dump(@where_conditions)
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
          unless errors.empty?
            error = [errors.keys.first, errors.values.first].join(' ')
            raise Vodka::Client::ResourceException.new(error)
          end

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
          raise Vodka::Client::FailedActionException.new('Destroy failed') if metadata[:vodka_action_success] == false
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

Her::Model.send(:include, Vodka::Her::Extensions::ExtendedOrm)
