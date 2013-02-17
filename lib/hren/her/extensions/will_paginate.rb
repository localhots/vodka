require 'will_paginate/collection'

module Hren
  module Her
    module Extensions
      module WillPaginate
        extend ActiveSupport::Concern

        module ClassMethods
          def paginate(params)
            all(params)
          end
        end
      end

      module PaginatedCollection
        extend ActiveSupport::Concern

        def current_page
          metadata[:page].to_i if metadata.has_key?(:page)
        end

        def per_page
          metadata[:per_page].to_i if metadata.has_key?(:per_page)
        end

        def total_entries
          metadata[:total].to_i if metadata.has_key?(:total)
        end
      end
    end
  end
end

Her::Model.send(:include, Hren::Her::Extensions::WillPaginate)
Her::Collection.send(:include, Hren::Her::Extensions::PaginatedCollection)
