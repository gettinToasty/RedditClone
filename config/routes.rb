Rails.application.routes.draw do

  resources :sessions, only: [:create, :new, :destroy]

  resources :users, only: [:new, :show, :create]

  resources :posts, except: [:index, :new, :create]

  root "subs#index"

  resources :subs do
    resources :posts, only: [:new, :create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
