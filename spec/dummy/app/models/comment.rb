class Comment
  include MongoMapper::Document
  key :article_id, Integer
  key :body, String
  key :author_id, String

  many :likes

  def author
    Author.find(author_id)
  end
end
