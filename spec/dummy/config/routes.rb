Dummy::Application.routes.draw do
  namespace :vodka do
    resources :articles do
      collection{ get :hello }
    end
  end
end
