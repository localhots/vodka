class CommentPresenter < VodkaPresenter
  def present
    json(
      body: resource.body,
      author: resource.author.try(:present),
      likes: likes
    )
  end

  def likes
    resource.likes.map{ |like| like.author.try(:present) }
  end
end
