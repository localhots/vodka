require 'her'
require 'multi_json'

module Hren
end

require 'hren/version'
require 'hren/configuration'

require 'hren/server/middleware/signed_request'
require 'hren/server/handlers/resource'
require 'hren/server/handlers/response'
require 'hren/server/handlers/scafflold'
require 'hren/server/controllers/hren_controller'

require 'hren/client/middleware/signed_request'
require 'hren/extensions/extended_orm'
require 'hren/extensions/will_paginate'
