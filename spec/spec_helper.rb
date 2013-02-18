require 'i18n'

# App
require 'vodka/client'

# Dummy Client
require 'client/article'

Vodka::Client.configure do |c|
  c.api_url = 'http://0.0.0.0:3000/vodka'
  c.secret = 'whatever'
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
