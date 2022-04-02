Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments
  end

  get "posts/index"
  root "posts#welcome"
end
