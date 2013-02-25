require 'spec_helper'

describe "Nested resources" do
  it 'should work' do
    comments = Article.first.comments
    comments.size.should > 0
    comments.first.should be_instance_of(Comment)
  end
end
