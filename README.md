# Hren
Hren uses [Her](https://github.com/remiprev/her) to make communication between two rails apps a lot easier.

## What the hell is hren?
"Hren" means "horseradish" in Russian. It is also a common Russian euphemism for "dick", so is the word "her".

## Installation
Add this gem to both server and client application Gemfiles:
```ruby
gem 'hren'
```

## Configuring server
Add initializer `hren_setup.rb` to `config/initializers`:

```ruby
require 'hren/server'

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
class ArticlesController < HrenController
  def best
    respond_with_collection(Article.best)
  end
end

# comments_controller.rb
class CommentsController < HrenController
  def approve
    response.success = resource.approve
    respond_with_resource
  end
end
```

Modify your models:
# article.rb
```ruby
class Article < ActiveRecord::Base
  has_many :comments
  scope :best, ->{ where('rating > 100') }

  # Defines fields and actions that would be used in :as_json method
  present_with :id, :title, :body, :created_at
end

# comment.rb
class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

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
require 'hren/client'

Hren::Client.configure do |c|
  c.api_url = 'https://api.myproject.org/hren'
  c.secret = 'whatever' # Same as server's
end
```




