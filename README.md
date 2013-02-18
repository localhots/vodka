# Hren
Hren uses [Her](https://github.com/remiprev/her) to make communication between two rails apps a lot easier.

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
gem 'hren', require: 'hren/server'

# Client
gem 'hren', require: 'hren/client'
```

## Configuring server
Add initializer `hren_setup.rb` to `config/initializers`:

```ruby
Hren::Server.configure do |c|
  c.secret = 'whatever'
end
```

Add hren namespaced resources to your `config/routes.rb`
```ruby
namespace :hren do
  resources :articles do
    collection { get :best }
    resources :comments do
      member { put :approve }
    end
  end
end
```

Create controllers in `app/controllers/hren`
```ruby
# articles_controller.rb
class ArticlesController < Hren::Server::HrenController
  def best
    respond_with_collection(Article.best)
  end
end

# comments_controller.rb
class CommentsController < Hren::Server::HrenController
  def approve
    hren_response.success = resource.approve
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
Add initializer `hren_setup.rb` to `config/initializers`:

```ruby
Hren::Client.configure do |c|
  c.api_url = 'https://api.myproject.org/hren'
  c.secret = 'whatever' # Same as server's
end
Hren::Client.config.configure_her!
```

## Usage
After all the configuration is done, you can use your Her-applied models with all the new possibilities.

Hren adds some convinient methods to client and supports them on server:
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

## What the hell is hren?
"Hren" means "horseradish" in Russian. It is also a common Russian euphemism for "dick", so is the word "her".
