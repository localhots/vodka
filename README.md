# Hren
Hren uses [Her](https://github.com/remiprev/her) to make communication between two rails apps a lot easier.

## What the hell is hren?
"Hren" means "horseradish" in Russian. It is also a common Russian euphemism for "dick", so is the word "her".

## Installation
Add this gem to both server and client application Gemfiles:
```ruby
# Server
gem 'hren', require: 'hren/server'

# Client
gem 'hren', require: 'hren/client'
```

## Configuration
Add initializer `hren_setup.rb` to `config/initializers` of both apps:
```ruby
# Server
Hren::Server.configure do |c|
  c.secret = 'whatever'
end

# Client
Hren::Client.configure do |c|
  c.secret = 'whatever' # Same as server's
end
```
