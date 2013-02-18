require 'spec_helper'

describe Vodka::Client::Middleware::ErrorAware do
  it 'should throw exception for a forbidden response' do
    Vodka::Client.config.secret = 'invalid'

    expect{
      Article.first
    }.to raise_exception(Vodka::Client::ForbiddenException, Vodka::Client::ForbiddenException::MESSAGE)

    Vodka::Client.config.secret = 'whatever'
  end

  it 'should throw exception for when response was not found' do
    expect{
      Article.find(0)
    }.to raise_exception(Vodka::Client::NotFoundException, Vodka::Client::NotFoundException::MESSAGE)
  end
end
