Rails.application.routes.draw do
  resources :people
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # sessões
  resources :sessions, only: %i(new create destroy)
end
