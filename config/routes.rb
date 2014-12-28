Rails.application.routes.draw do
  root to: 'home#index'
  get '/error', to: 'home#error', as: 'error'
  get '/auth/twitter/callback', to: 'sessions#create', as: 'callback'
  get '/auth/failure', to: 'sessions#error', as: 'failure'
  get '/account', to: 'user#my_timeline', as: 'show'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  resource :user, only: [], path: "" do
    post 'follow(/:username)', to: 'user#follow', as: 'follow'
    post 'unfollow/:username', to: 'user#unfollow', as: 'unfollow'
    post 'tweet(/:tweet)', to: 'user#tweet', as: 'tweet'
    post 'comment/:tweet_id', to: 'user#comment', as: 'comment'
    post 'message(/:username)(/:body)', to: 'user#message', as: 'message'
    get 'my_tweets', to: 'user#my_tweets', as: 'my_tweets'
    get 'friends', to: 'user#friends', as: 'friends'
    get 'friends_timeline', to: 'user#friends_timeline', as: 'friends_timeline'
    get 'single_timeline(/:username)', to: 'user#single_timeline', as: 'single_timeline'
  end
end
