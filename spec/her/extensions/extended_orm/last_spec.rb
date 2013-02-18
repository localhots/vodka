require 'spec_helper'

describe Vodka::Her::Extensions::ExtendedOrm do
  describe '.last' do
    it 'should return the last record' do
      article = Article.last
      article.should be_instance_of(Article)
      article.id.should be_present
    end
  end
end
