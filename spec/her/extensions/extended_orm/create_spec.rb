require 'spec_helper'

describe Hren::Her::Extensions::ExtendedOrm do
  describe '#create' do
    it 'should return a new record' do
      article = Article.create(title: 'foo')
      article.id.should be_present
    end

    it 'should return a new record with errors' do
      article = Article.create(title: '')
      article.id.should_not be_present
      article.errors[:title].should == ["can't be blank"]
    end
  end

  describe '#create!' do
    it 'should return a new record without rising exception' do
      expect {
        article = Article.create(title: 'foo')
        article.id.should be_present
      }.not_to raise_exception
    end

    it 'should raise exception for a record with errors' do
      expect {
        article = Article.create!(title: '')
        article.id.should_not be_present
        article.errors[:title].should be_present
      }.to raise_exception(Exception, "title can't be blank")
    end
  end
end
