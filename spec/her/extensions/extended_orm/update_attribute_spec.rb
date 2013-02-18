require 'spec_helper'

describe Vodka::Her::Extensions::ExtendedOrm do
  describe '#update_attribute' do
    it 'should update attribute of a record' do
      article = Article.find(1)
      article.should be_instance_of(Article)

      article.update_attribute(:title, 'lalala')
      article.title.should == 'lalala'
    end

    it 'should return a record with errors' do
      article = Article.find(1)
      article.should be_instance_of(Article)

      article.update_attribute(:title, '')
      article.title.should == ''
      article.errors[:title].should == ["can't be blank"]
    end
  end

  describe '#update_attribute!' do
    it 'should update attribute of a record without rising exception' do
      expect {
        article = Article.find(1)
        article.should be_instance_of(Article)

        article.update_attribute!(:title, 'mumumu')
        article.title.should == 'mumumu'
      }.not_to raise_exception
    end

    it 'should raise exception for a record with errors' do
      expect {
        article = Article.find(1)
        article.should be_instance_of(Article)

        article.update_attribute!(:title, '')
        article.title.should == ''
      }.to raise_exception(Vodka::Client::ResourceException, "title can't be blank")
    end
  end
end
