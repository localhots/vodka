# encoding: utf-8
require 'spec_helper'

describe Vodka::Client::Middleware::SignedRequest do
  it 'should pass current locale and recieve correctly localized response' do
    I18n.locale = :en
    Article.hello.metadata[:hello].should == 'Hello World!'

    I18n.locale = :ru
    Article.hello.metadata[:hello].should == 'Привет, мир!'
  end
end
