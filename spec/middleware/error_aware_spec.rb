require 'spec_helper'

describe Vodka::Client::Middleware::ErrorAware do
  it 'should throw exception for a forbidden response' do
    @old_secret = Vodka::Client.config.request_secret.dup
    Vodka::Client.config.request_secret = 'invalid'

    expect{
      Article.first
    }.to raise_exception(Vodka::Client::ForbiddenException, Vodka::Client::ForbiddenException::MESSAGE)

    Vodka::Client.config.request_secret = @old_secret
  end

  it 'should throw exception for when response was not found' do
    expect{
      Article.find(0)
    }.to raise_exception(Vodka::Client::NotFoundException, Vodka::Client::NotFoundException::MESSAGE)
  end
end
