require 'hren'
require 'hren/client/exceptions/exception'
require 'hren/client/exceptions/failed_action_exception'
require 'hren/client/exceptions/forbidden_exception'
require 'hren/client/exceptions/resource_exception'
require 'hren/client/middleware/signed_request'
require 'hren/client/middleware/forbidden_aware'
require 'hren/her/extensions/extended_orm'
require 'hren/her/extensions/will_paginate' if defined?(WillPaginate)

module Hren
  module Client
    extend Configurable
  end
end
