class Like
  include MongoMapper::EmbeddedDocument
  key :author_id, String
  embedded_in :comment

  def author
    Author.find(author_id)
  end
end
