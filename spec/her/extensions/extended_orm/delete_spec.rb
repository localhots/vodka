require 'spec_helper'

describe Vodka::Her::Extensions::ExtendedOrm do
  describe '#delete' do
    it 'should call #destroy method' do
      article = Article.create(title: 'test')
      article.metadata[:vodka_action_success] = true
      article.stub(:destroy).and_return(article)
      article.should_receive(:destroy).once
      article.delete
    end
  end

  describe '#delete!' do
    it 'should call #destroy! method' do
      article = Article.create(title: 'test')
      article.metadata[:vodka_action_success] = true
      article.stub(:destroy!).and_return(article)
      article.should_receive(:destroy!).once
      article.delete!
    end
  end
end
