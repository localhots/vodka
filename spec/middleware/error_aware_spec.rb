require 'spec_helper'

describe Hren::Client::Middleware::ErrorAware do
  it 'should throw exception for a forbidden response' do
    Hren::Client.config.secret = 'invalid'

    expect{
      Article.first
    }.to raise_exception(Hren::Client::ForbiddenException, Hren::Client::ForbiddenException::MESSAGE)

    Hren::Client.config.secret = 'whatever'
  end

  it 'should throw exception for when response was not found' do
    expect{
      Article.find(0)
    }.to raise_exception(Hren::Client::NotFoundException, Hren::Client::NotFoundException::MESSAGE)
  end
end
