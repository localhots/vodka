module Vodka
  module Her
    module Extensions
      module Paginated
        extend ActiveSupport::Concern

        module ClassMethods
          def paginate(params)
            response = all(params)
            PaginatedCollection.new(response, response.metadata, response.errors)
          end
        end
      end

      class PaginatedCollection < ::Her::Collection
        def current_page
          metadata[:current_page].to_i
        end

        def per_page
          metadata[:per_page].to_i
        end

        def total_entries
          metadata[:total_entries].to_i
        end
      end
    end
  end
end

Her::Model.send(:include, Vodka::Her::Extensions::Paginated)
