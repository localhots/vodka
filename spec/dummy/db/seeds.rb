Article.delete_all
ActiveRecord::Base.connection.execute('VACUUM')
ActiveRecord::Base.connection.execute('DELETE FROM SQLITE_SEQUENCE WHERE name="articles"')
Author.delete_all
Comment.delete_all

authors = 10.times.map{ Author.create(name: 'John Doe') }

10.times do
  article = Article.create(title: 'Whatever', author_id: authors.sample.id.to_s)
  5.times do
    comment = Comment.create(article_id: article.id.to_s, author_id: authors.sample.id.to_s, body: 'Nice!')
    5.times do
      comment.likes << Like.new(author_id: authors.sample.id.to_s)
    end
    comment.save
  end
end
