Rails.application.routes.draw do
  resources :people do
    collection do
      get :admins
    end
    member do
      get :changed
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # sessões
  resources :sessions, only: %i(new create destroy)

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

end
