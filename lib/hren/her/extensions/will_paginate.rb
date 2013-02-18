require 'will_paginate/collection'

module Hren
  module Her
    module Extensions
      module WillPaginate
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
          metadata[:page].to_i
        end

        def per_page
          metadata[:per_page].to_i
        end

        def total_entries
          metadata[:total].to_i
        end
      end
    end
  end
end

Her::Model.send(:include, Hren::Her::Extensions::WillPaginate)
