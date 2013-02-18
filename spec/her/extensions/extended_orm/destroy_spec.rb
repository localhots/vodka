require 'spec_helper'

describe Hren::Her::Extensions::ExtendedOrm do
  describe '#destroy' do
    it 'should return a record with successful action status' do
      article = Article.create(title: 'test')
      article.destroy
      article.metadata[:hren_action_success].should be_true
    end

    it 'should return a record with failed action status' do
      article = Article.create(title: 'special')
      article.destroy
      article.metadata[:hren_action_success].should be_false
    end
  end

  describe '#destroy!' do
    it 'should return a record with successful action status without rising exception' do
      expect {
        article = Article.create(title: 'test')
        article.destroy!
        article.metadata[:hren_action_success].should be_true
      }.not_to raise_exception
    end

    it 'should raise exception for a record with failed action status' do
      expect {
        article = Article.create(title: 'special')
        article.destroy!
        article.metadata[:hren_action_success].should be_false
      }.to raise_exception(Hren::Client::FailedActionException, 'Destroy failed')
    end
  end
end
