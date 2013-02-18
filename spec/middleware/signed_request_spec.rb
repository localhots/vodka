require 'spec_helper'

describe Vodka::Client::Middleware::SignedRequest do
  it 'should sign requests properly so there is no forbidden exception' do
    expect {
      Article.first.should be_instance_of(Article)
    }.not_to raise_exception(Vodka::Client::ForbiddenException, '403 Forbidden')
  end
end
