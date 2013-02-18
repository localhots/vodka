require 'spec_helper'

describe Vodka::Her::Extensions::Paginated do
  describe '.paginate' do
    it 'should return a collection with desired page, items per page and page info in metadata' do
      total = Article.all.count
      articles = Article.paginate(page: 2, per_page: 5)

      articles.should be_instance_of(Vodka::Her::Extensions::PaginatedCollection)
      articles.size.should == 5
      articles.current_page.should == 2
      articles.per_page.should == 5
      articles.total_entries.should == total
    end

    it 'should work with where-conditions correctly' do
      total = Article.all.count
      articles = Article.where('id > ?', 1).where(title: 'Whatever').paginate(page: 1, per_page: 3)

      articles.should be_instance_of(Vodka::Her::Extensions::PaginatedCollection)
      articles.size.should == 3
      articles.current_page.should == 1
      articles.per_page.should == 3
      articles.total_entries.should == total

      articles.each do |article|
        article.id.should > 1
        article.title.should == 'Whatever'
      end
    end
  end
end
