Rails.application.routes.draw do
  resources :pokemon
  resources :trainers
  root "pokemon#index"

  resource :pokemon do
      get "pokemon_capturado"
  end

end
