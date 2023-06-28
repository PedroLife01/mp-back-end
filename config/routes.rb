Rails.application.routes.draw do
  namespace :api do
    post 'auth/login', to: "authentication#login"
    
    resources :user
    resources :book
    resources :movie
    resources :show
    resources :tag
  end

end
