class Article < ActiveRecord::Base
  present_with :id, :title
  attr_accessible :title
  validates_presence_of :title
  before_destroy :ensure_article_in_not_special

  def ensure_article_in_not_special
    return false if title == 'special'
  end
end
