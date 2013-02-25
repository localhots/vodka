require 'vodka'
require 'vodka/server/middleware/signed_request'
require 'vodka/server/railtie'
require 'vodka/server/response'
require 'vodka/server/handlers/resource'
require 'vodka/server/handlers/response'
require 'vodka/server/handlers/scaffold'
require 'vodka/server/controllers/vodka_controller'
require 'vodka/server/presenters/vodka_presenter'
require 'vodka/server/plugins/presentable'

module Vodka
  module Server
    extend Configurable
    config.her_auto_configure = false
  end
end
