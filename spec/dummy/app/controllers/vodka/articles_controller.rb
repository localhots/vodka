module Vodka
  class ArticlesController < VodkaController
    def hello
      vodka_response.metadata[:hello] = I18n.t('hello')
      respond_with_collection([])
    end
  end
end
