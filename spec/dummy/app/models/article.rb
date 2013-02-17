class Article < ActiveRecord::Base
  present_with :id, :title
  attr_accessible :title
  validates_presence_of :title
end
