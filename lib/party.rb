require 'i18n'
require 'vodka/client'
require './spec/client/article'
require './spec/client/author'
require './spec/client/comment'

Vodka::Client.configure do |c|
  c.api_url = 'http://0.0.0.0:3000/vodka'
  c.request_secret = '8089c2189321798bf60df6b8c01bb661fb585080'
  c.response_secret = '3ecb42ac23cd58994a6518971e7e31d2f4545e3c'
end
