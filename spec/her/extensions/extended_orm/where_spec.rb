require 'spec_helper'

describe Hren::Her::Extensions::ExtendedOrm do
  describe '.where' do
    before(:all) do
      @article = Article.create(title: 'looking for this one')
      @title = "where collection test ##{rand}"
      5.times do
        Article.create(title: @title)
      end
    end

    it 'should return a collection by a hash condition' do
      articles = Article.where(id: @article.id, title: @article.title).all
      articles.size.should == 1
      articles.first.id.should == @article.id
    end

    it 'should return a collection by an array condition' do
      articles = Article.where('id = ? and title = ?', @article.id, @article.title).all
      articles.size.should == 1
      articles.first.id.should == @article.id
    end

    it 'should return a collection by a chaining condition' do
      articles = Article.where('id = ?', @article.id).where(title: @article.title).all
      articles.size.should == 1
      articles.first.id.should == @article.id
    end

    it 'should return a full collection by a permissive condition' do
      articles = Article.where(title: @title).all
      articles.size.should == 5
      articles.each do |article|
        article.title.should == @title
      end
    end
  end
end
