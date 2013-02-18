require 'i18n'
require 'vodka/client'
require './spec/client/article'

Vodka::Client.configure do |c|
  c.api_url = 'http://0.0.0.0:3000/vodka'
  c.secret = 'whatever'
end
Vodka::Client.configure_her!
