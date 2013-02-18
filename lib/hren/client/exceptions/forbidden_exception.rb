module Hren
  module Client
    class ForbiddenException < ::Exception
      def initialize
        super('403 Forbidden')
      end
    end
  end
end
