# Vodka
Vodka makes communication easier. Always.

Vodka uses [Her](https://github.com/remiprev/her) as a REST client.

It currently supports these ORMs on server:
- [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord)
- [MongoMapper](https://github.com/jnunemaker/mongomapper)

And the following plugins:
- [WillPaginate](https://github.com/mislav/will_paginate)

Vodka supports I18n. If you change locale on client you may expect getting response from server in this locale.

Vodka signs all requests and responses so you can relax and hope nothing goes wrong. Or your sensitive data will be stolen by some Russian gangsters. Or there will be some man-in-the-middle that will attack you. Anyway, as long as you're not using SSL for all your requests you're screwed.

## Installation
Add this gem to both server and client application Gemfiles:
```ruby
# Server
gem 'vodka', require: 'vodka/server'

# Client
gem 'vodka', require: 'vodka/client'
```

## Configuring server
Add initializer `vodka_setup.rb` to `config/initializers`:

```ruby
Vodka::Server.configure do |c|
  c.request_secret = '8089c2189321798bf60df6b8c01bb661fb585080'
  c.response_secret = '3ecb42ac23cd58994a6518971e7e31d2f4545e3c'
end
```

Add vodka namespaced resources to your `config/routes.rb`
```ruby
namespace :vodka do
  resources :articles do
    collection { get :best }
    resources :comments do
      member { put :approve }
    end
  end
end
```

Create controllers in `app/controllers/vodka`
```ruby
# articles_controller.rb
class ArticlesController < VodkaController
  def best
    respond_with_collection(Article.best)
  end
end

# comments_controller.rb
class CommentsController < VodkaController
  def approve
    vodka_response.success = resource.approve
    respond_with_resource
  end
end
```

Modify your models:
```ruby
# article.rb
class Article < ActiveRecord::Base
  has_many :comments
  scope :best, ->{ where('rating > 100') }
  validates_presence_of :title, :body

  # Defines fields and actions that would be used in :as_json method
  present_with :id, :title, :body, :created_at
end

# comment.rb
class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates_presence_of :body

  # Defines fields and actions that would be used in :as_json method
  present_with :id, :body, :author_name, :created_at

  def approve
    update_attributes(status: 'approved')
  end

  def author_name
    [user.first_name, user.last_name].join(' ')
  end
end
```

## Configuring client
Add initializer `vodka_setup.rb` to `config/initializers`:

```ruby
Vodka::Client.configure do |c|
  c.api_url = 'https://api.myproject.org/vodka'
  c.request_secret = '8089c2189321798bf60df6b8c01bb661fb585080'  # Same as server's
  c.response_secret = '3ecb42ac23cd58994a6518971e7e31d2f4545e3c' # Same as server's
end
Vodka::Client.configure_her!

# Instead of calling Vodka::Client.configure_her! you may configure her yourself
# Her::API.setup(url: Vodka::Client.config.api_url) do |c|
#   c.use Vodka::Client::Middleware::ErrorAware
#   c.use Vodka::Client::Middleware::SignedRequest
#   c.use Faraday::Request::UrlEncoded
#   c.use Vodka::Client::Middleware::SignedResponse
#   c.use Her::Middleware::SecondLevelParseJSON
#   c.use Faraday::Adapter::NetHttp
# end
```

## Usage
After all the configuration is done, you can use your Her-applied models with all the new possibilities.

Vodka adds some convinient methods to client and supports them on server:
- `.create!` (throws exception on error)
- `.paginate` (returns WillPaginate-compatible collection)
- `.where` (supports chaining the way you expect)
- `.first`
- `.last`
- `#update_attribute`
- `#update_attribute!` (throws exception on error)
- `#update_attributes`
- `#update_attributes!` (throws exception on error)
- `#destroy!` (throws exception on error)
- `#delete` (acts like `#destroy`)
- `#delete!` (acts like `#destroy!`)

## Is it secure? Should I use it in production?
Hell no. At least not yet.
