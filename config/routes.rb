Rails.application.routes.draw do
  root 'users#index'

  resources :users

  get 'boxes' => 'pages#boxes'
end
