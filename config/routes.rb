Rails.application.routes.draw do
  resources :images do
    resources :tag_groups
  end
  devise_for :users
  root to: "frontpage#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get '/about', to: "static_stuff#about"

  get '/people', to: "static_stuff#people"

  get '/contact', to: "static_stuff#contact"

end
