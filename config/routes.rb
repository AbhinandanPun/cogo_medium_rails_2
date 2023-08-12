Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:show, :create, :update] do    
    collection do
      get 'history', to: 'users#history'
      get 'subscribe', to: 'users#subscribe'
      post 'login', to: 'users#login'
    end
  end

  post '/follow/:username', to: 'follow#followUser', as: :follow_user

  get 'payments', to: 'payments#create', as: :payments_create # redirect was not working with post
  get '/payment/success', to: 'payments#success', as: :payment_success
  get '/payment/failure', to: 'payments#failure', as: :payment_failure

  get 'subscriptions', to: 'subscriptions#index'
  get 'subscriptions/create', to:'subscriptions#create', as: :subscriptions_create # same not working with post

  resources :posts, only: [:index, :destroy, :show, :create, :update], param: :id do
    collection do
      get 'share/:id', to: 'posts#share'
      get 'filter', to: 'posts#filter'
      get 'topic', to: 'posts#topic'
      get 'recommended', to: 'posts#recommend'
    end
  end
  post '/like/:post_id', to: 'like#like', as: :like_post
  post '/comment/:post_id', to: 'comment#comment', as: :comment_post

  resources :search, only: [] do
    collection do
      get 'users', to: 'search#search_users'
      get 'posts', to: 'search#search_posts'
    end
  end

  post 'drafts/:id/post', to: 'drafts#post'
  resources :drafts, only: [:create, :update, :show, :destroy] 

  resources :user_post_saves, only: [:create, :destroy]
  resources :lists, only: [:index, :show, :create, :update, :destroy], param: :list_id do
    member do
      post 'post/:post_id', to: 'lists#addToList'
      delete 'post/:post_id', to: 'lists#removeFromList'
      get 'share/', to: 'lists#shareList'
    end
  end
  resources :list_posts, only: [:create, :destroy]
  resources :shares, only: [:create]
end
