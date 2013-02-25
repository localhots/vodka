class Article < ActiveRecord::Base
  attr_accessible :title, :author_id
  validates_presence_of :title
  before_destroy :ensure_article_in_not_special

  def ensure_article_in_not_special
    return false if title == 'special'
  end

  def author
    Author.find(author_id) if author_id?
  end

  def comments
    Comment.where(article_id: id)
  end
end
