class ArticlePresenter < VodkaPresenter
  def present
    json(
      id: resource.id,
      title: resource.title,
      author: resource.author.try(:present)
    )
  end
end
