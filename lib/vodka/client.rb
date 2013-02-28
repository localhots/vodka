require 'vodka'
require 'vodka/client/exceptions/exception'
require 'vodka/client/exceptions/failed_action_exception'
require 'vodka/client/exceptions/forbidden_exception'
require 'vodka/client/exceptions/not_found_exception'
require 'vodka/client/exceptions/resource_exception'
require 'vodka/client/exceptions/security_exception'
require 'vodka/client/middleware/signed_request'
require 'vodka/client/middleware/signed_response'
require 'vodka/client/middleware/error_aware'

module Vodka
  module Client
    extend Configurable
  end
end
