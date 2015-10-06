Rails.application.routes.draw do

  ############
  # CONCERNS #
  ############

  concern :reportable do
    post "report", on: :member
  end

  concern :commentable do
    post :comment, on: :member
  end

  ##################
  # RESTFUL ROUTES #
  ##################
  
  resources :tags do
    collection do
      get "suggest"
    end
  end

  resources :tag_group_changes, only: [:show] do

  end

  resources :images do
    member do
      post "favorite"
      post "created"
      delete "unfavorite"
    end

    resources :tag_groups do 
      resources :changes, only: [:index], controller: :tag_group_changes
    end

    concerns :reportable, :commentable
  end

  devise_for :users, path: "accounts", :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show, :edit, :update] do
    ##
    # This is done so it's easier to see a users collections.
    # Meanwhile, creation and modification of collections is its own thing.
    resources :collections, only: [:index]
  end

  resources :collections, except: [:index] do
    ##
    # OK we get non-REST here
    resources :images, only: [:create, :destroy], controller: :collection_images  do
    ##
    # An action which sees if an image already exists in the collection
    get "exists", on: :collection
  end

  resources :curatorships, except: [:index, :show]
    member do
      post "subscribe"
      delete "unsubscribe"
      ##
      # Refactor these out eventually
      post "add"
      delete "remove"
    end
  end

  resources :notifications, only: [:index] do
    collection do 
      get 'unread'
      post 'mark_all_read'
    end

    member do
      post 'read'
    end
  end

  ################
  # ADMIN ROUTES #
  ################

  namespace :admin do
    resources :images, only: [:index, :destroy] do
      post "absolve", on: :member
    end
  end

  ########################
  # SINGLE ACTION ROUTES #
  ########################

  #################
  # STATIC ROUTES #
  #################

  root to: "frontpage#index"

  get 'about', to: "static_stuff#about"
  get 'people', to: "static_stuff#people"
  get 'contact', to: "static_stuff#contact"
  get 'rules', to: "static_stuff#rules"
  get 'faq', to: "static_stuff#faq"
  get 'help', to: "static_stuff#help"
  get 'press', to: "static_stuff#press"

  get 'settings', to: 'users#edit'
  post 'settings', to: 'users#update'

  get 'search', to: "images#search"
  
end
