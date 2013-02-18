Dummy::Application.routes.draw do
  namespace :hren do
    resources :articles do
      collection{ get :hello }
    end
  end
end
