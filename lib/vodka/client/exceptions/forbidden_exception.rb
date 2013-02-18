module Vodka
  module Client
    class ForbiddenException < ::Exception
      MESSAGE = '403 Forbidden'

      def initialize
        super(MESSAGE)
      end
    end
  end
end
