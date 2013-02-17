module Hren
  module Extensions
    module WillPaginate
      def paginate(params)
        response = all(params)
        WillPaginate::Collection.create(
          response.metadata[:page],
          response.metadata[:per_page],
          response.metadata[:count],
          response
        )
      end
    end
  end
end

Her::Model.send(:extend, Hren::Extensions::WillPaginate) if defined?(WillPaginate)
