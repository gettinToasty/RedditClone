Rails.application.routes.draw do

  resources :sessions, only: [:create, :new, :destroy]

  resources :users, only: [:new, :show, :create]

  resources :posts, except: [:index, :new] do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: :show

  root "subs#index"

  resources :subs do
    resources :posts, only: [:new]
  end

  post 'posts/:id/upvote', to: 'posts#upvote', as: :post_upvote
  post 'comments/:id/upvote', to: 'comments#upvote', as: :comment_upvote

  post 'posts/:id/downvote', to: 'posts#downvote', as: :post_downvote
  post 'comments/:id/downvote', to: 'comments#downvote', as: :comment_downvote

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
