Dummy::Application.routes.draw do
  namespace :vodka do
    resources :articles do
      collection{ get :hello }
      resources :comments
    end
    resources :authors
  end

  resources :articles
end
