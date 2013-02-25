class AuthorCustomPresenter < VodkaPresenter
  def present
    json(id: resource.id, name: resource.name)
  end
end
