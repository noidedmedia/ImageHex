Rails.application.routes.draw do

  ############
  # CONCERNS #
  ############

  concern :reportable do
    post "report", on: :member
  end

  ##################
  # RESTFUL ROUTES #
  ##################

  resources :images do
    resources :tag_groups
    concerns :reportable
  end
  devise_for :users

  ################
  # ADMIN ROUTES #
  ################

  namespace :admin do
    resources :images, only: [:index, :destroy] do
      post "absolve", on: :member
    end
  end
  #################
  # STATIC ROUTES #
  #################

  root to: "frontpage#index"


  get '/about', to: "static_stuff#about"

  get '/people', to: "static_stuff#people"

  get '/contact', to: "static_stuff#contact"


  get '/search', to: "images#search"
end
