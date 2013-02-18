# Vodka
Vodka makes communication easier. Always.

Vodka uses [Her](https://github.com/remiprev/her) as a REST client.

It currently supports ORM's on server:
- [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord)
- [MongoMapper](https://github.com/jnunemaker/mongomapper)

Plugins:
- [WillPaginate](https://github.com/mislav/will_paginate)

It is strongly recommended *NOT* to use this gem in production (yet).

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
  c.secret = 'whatever'
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
class CommentsController < Vodka::Server::VodkaController
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
  c.secret = 'whatever' # Same as server's
end
Vodka::Client.configure_her!
```

## Usage
After all the configuration is done, you can use your Her-applied models with all the new possibilities.

Vodka adds some convinient methods to client and supports them on server:
- `.create!` (throws exception on error)
- `.paginate` (same as `.all`, for WillPaginate compatibility)
- `.where` (supports chaining the way you expect)
- `#update_attribute`
- `#update_attribute!` (throws exception on error)
- `#update_attributes`
- `#update_attributes!` (throws exception on error)
- `#destroy!` (throws exception on error)
- `#delete` (acts as `#destroy`)
- `#delete!` (acts as `#destroy!`)
