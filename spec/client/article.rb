class Article
  include Her::Model
  custom_get :hello
  has_many :comments
  belongs_to :author
end
