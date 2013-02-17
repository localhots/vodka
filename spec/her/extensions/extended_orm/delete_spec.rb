require 'spec_helper'

describe Hren::Her::Extensions::ExtendedOrm do
  describe '#delete' do
    it 'should call #destroy method' do
      article = Article.create(title: 'test')
      article.metadata[:hren_action_success] = true
      article.stub(:destroy).and_return(article)
      article.should_receive(:destroy).once
      article.delete
    end
  end

  describe '#delete!' do
    it 'should call #destroy! method' do
      article = Article.create(title: 'test')
      article.metadata[:hren_action_success] = true
      article.stub(:destroy!).and_return(article)
      article.should_receive(:destroy!).once
      article.delete!
    end
  end
end
