Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/top'
  get '/about', to: 'homes#about'
  devise_for :users
  resources :posts
  get 'mypage', to: 'users#index'
  resources :users, only: [:edit, :show, :update, :destroy]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
