require 'spec_helper'

describe Hren::Her::Extensions::ExtendedOrm do
  describe '#update_attributes' do
    it 'should update attributes of a record' do
      article = Article.find(1)
      article.should be_instance_of(Article)

      article.update_attributes(title: 'lalala')
      article.title.should == 'lalala'
    end

    it 'should return a record with errors' do
      article = Article.find(1)
      article.should be_instance_of(Article)

      article.update_attributes(title: '')
      article.title.should == ''
      article.errors[:title].should == ["can't be blank"]
    end
  end

  describe '#update_attributes!' do
    it 'should update attributes of a record without rising exception' do
      expect {
        article = Article.find(1)
        article.should be_instance_of(Article)

        article.update_attributes!(title: 'mumumu')
        article.title.should == 'mumumu'
      }.not_to raise_exception
    end

    it 'should raise exception for a record with errors' do
      expect {
        article = Article.find(1)
        article.should be_instance_of(Article)

        article.update_attributes!(title: '')
        article.title.should == ''
      }.to raise_exception(Exception, "title can't be blank")
    end
  end
end
