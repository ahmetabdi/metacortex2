Rails.application.routes.draw do
  resources :pages, only: [:index]
  resources :movies

  get "/search" => "search#global_search"
  root 'pages#index'
end
