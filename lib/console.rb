require 'i18n'
require 'hren/client'
require './spec/client/article'

Hren::Client.configure do |c|
  c.api_url = 'http://0.0.0.0:3000/hren'
  c.secret = 'whatever'
end
Hren::Client.configure_her!
