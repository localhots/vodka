require 'spec_helper'

describe Vodka::Her::Extensions::ExtendedOrm do
  describe '.first' do
    it 'should return the first record' do
      article = Article.first
      article.should be_instance_of(Article)
      article.id.should be_present
    end
  end
end
