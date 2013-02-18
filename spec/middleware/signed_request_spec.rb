require 'spec_helper'

describe Hren::Client::Middleware::SignedRequest do
  it 'should sign requests properly so there is no forbidden exception' do
    expect {
      Article.first.should be_instance_of(Article)
    }.not_to raise_exception(Hren::Client::ForbiddenException, '403 Forbidden')
  end
end
