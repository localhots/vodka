require 'spec_helper'

describe Hren::Her::Extensions::WillPaginate do
  describe '.paginate' do
    it 'should return a collection with desired page, items per page and page info in metadata' do
      total = Article.all.count
      articles = Article.paginate(page: 2, per_page: 5)
      articles.size.should == 5
      articles.current_page.should == 2
      articles.per_page.should == 5
      articles.total_entries.should == total
    end
  end
end
