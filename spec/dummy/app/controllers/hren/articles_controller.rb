module Hren
  class ArticlesController < HrenController
    def hello
      hren_response.metadata[:hello] = I18n.t('hello')
      respond_with_collection([])
    end
  end
end
