module Vodka
  module Client
    class NotFoundException < ::Exception
      MESSAGE = '404 Not Found'

      def initialize
        super(MESSAGE)
      end
    end
  end
end
