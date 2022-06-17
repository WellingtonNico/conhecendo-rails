Rails.application.routes.draw do
  resources :categories
  resources :books
  root 'pub#index'
  get 'pub/sobre'
  get 'livro/:id' => 'pub#book', as: 'pub_book'
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
  get "logout" => "sessions#destroy"

end
