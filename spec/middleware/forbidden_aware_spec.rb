require 'spec_helper'

describe Hren::Client::Middleware::SignedRequest do
  before do
    Hren::Client.config.secret = 'invalid'
  end

  after do
    Hren::Client.config.secret = 'whatever'
  end

  it 'should throw exception for a forbidden response' do
    expect{
      Article.first
    }.to raise_exception(Hren::Client::ForbiddenException, '403 Forbidden')
  end
end
