require 'i18n'

# App
require 'vodka/client'

# Dummy Client
require 'client/article'

Vodka::Client.configure do |c|
  c.api_url = 'http://0.0.0.0:3000/vodka'
  c.request_secret = '8089c2189321798bf60df6b8c01bb661fb585080'
  c.response_secret = '3ecb42ac23cd58994a6518971e7e31d2f4545e3c'
end
Vodka::Client.configure_her!

RSpec.configure do |c|
  # Use color in STDOUT
  c.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  c.tty = true

  # Use the specified formatter
  c.formatter = :documentation # :progress, :html, :textmate
end
