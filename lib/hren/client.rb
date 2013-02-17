require 'hren/client/middleware/signed_request'
require 'hren/her/extensions/extended_orm'
require 'hren/her/extensions/will_paginate' if defined?(WillPaginate)

module Hren
  module Client
    extend Configurable
  end
end
