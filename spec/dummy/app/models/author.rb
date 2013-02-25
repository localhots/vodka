class Author
  include Mongoid::Document
  field :name, type: String
  present_with AuthorCustomPresenter
end
