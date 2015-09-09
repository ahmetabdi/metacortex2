Rails.application.routes.draw do
  resources :pages, only: [:index]

  get "/search" => "search#global_search"
  root 'pages#index'
end
