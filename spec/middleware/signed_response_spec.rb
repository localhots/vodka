require 'spec_helper'

describe Vodka::Client::Middleware::SignedResponse do
  it 'raise exception if request id and response id dont match' do
    Vodka::Client::Middleware::SignedResponse.any_instance.stub(:response_id).and_return('bullshit')

    expect {
      Article.first
    }.to raise_exception(Vodka::Client::SecurityException, 'Response ID mismatch')
  end

  it 'raise exception if response signature is invalid' do
    Vodka::Client::Middleware::SignedResponse.any_instance.stub(:response_signature).and_return('bullshit')

    expect {
      Article.first
    }.to raise_exception(Vodka::Client::SecurityException, 'Invalid response signature')
  end
end
