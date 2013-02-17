# App
require 'hren'
require 'hren/client'

# Dummy Client
require 'client/article'

Hren::Client.configure do |c|
  c.api_url = 'http://0.0.0.0:3000/hren'
  c.secret = 'whatever'
end
Hren::Client.config.configure_her!

RSpec.configure do |c|
  # Use color in STDOUT
  c.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  c.tty = true

  # Use the specified formatter
  c.formatter = :documentation # :progress, :html, :textmate
end
