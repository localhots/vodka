require 'vodka'
require 'vodka/client/exceptions/exception'
require 'vodka/client/exceptions/failed_action_exception'
require 'vodka/client/exceptions/forbidden_exception'
require 'vodka/client/exceptions/not_found_exception'
require 'vodka/client/exceptions/resource_exception'
require 'vodka/client/middleware/signed_request'
require 'vodka/client/middleware/error_aware'
require 'vodka/her/extensions/extended_orm'
require 'vodka/her/extensions/will_paginate'

module Vodka
  module Client
    extend Configurable
  end
end
