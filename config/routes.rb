require 'sidekiq/web'
Sidekiq::Web.set :sessions, false


Rails.application.routes.draw do
  resources :categories
  resources :books
  
  mount Sidekiq::Web => '/sidekiq'
  
  # rotas do controlador público
  # primeiro vem a url, depois a associação do controller, e depois o nome da url para ser usado
  # get '<url>' => '<controller#action>', as: '<variável de acesso à url>'
  root 'pub#index'
  get 'pub/sobre'
  get 'livro/:id' => 'pub#book', as: 'pub_book'
  get 'autor/:id' => 'pub#author', as: 'pub_author'
  get 'comprar/:id' => 'pub#buy', as: 'buy'
  get 'carrinho' => 'pub#cart', as: 'cart'
  delete 'carrinho/remover/:id' => 'pub#remove_cart_item', as: 'remove_cart_item'
  patch 'carrinho/alterar_item/:id' => 'pub#change_cart_item', as: 'change_cart_item'
  get 'fechar_pedido' => 'pub#close_order', as: 'close_order'
  get 'pedido/:id' => 'pub#order', as: 'order'
  get 'busca' => 'pub#search_book', as: 'search_book'


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
