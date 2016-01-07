Rails.application.routes.draw do
  mount Apipony::Engine => '/api/documentation'

  get "/@:id" => 'users#show'
  patch "/@:id" => "users#update"
  delete "/@:id" => "users#destroy"
  post "/@:id/subscribe" => "users#subscribe"
  delete "/@:id/unsubscribe" => "users#unsubscribe"

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


  resources :conversations do
    resources :messages, only: [:index, :new, :create]
    post :read, on: :member
  end

  resources :messages, only: [] do
    get 'unread', on: :collection
    get 'by_time', on: :collection
  end

  resources :tags do
    collection do
      get "suggest"
    end
  end
  ##
  # Not really resourceful at all but whatever yolo
  resources :stripe, only: [] do
    collection do
      get :authorize
      get :callback
    end
  end
  resources :commission_products do
    resources :commission_offers, shallow: true do
      member do 
        post 'accept'
        post 'confirm'
        get 'pay'
        post 'charge'
        get 'fullfill'
        post 'fill'
      end
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

  devise_for :users, 
    path: "accounts", 
    controllers: { 
    sessions: "users/sessions"
  }


  resources :users, only: [:show, :edit, :update, :index] do
    ##
    # This is done so it's easier to see a users collections.
    # Meanwhile, creation and modification of collections is its own thing.
    member do
      put 'enable_twofactor'
      get 'verify_twofactor'
      get 'backup_twofactor'
      put 'confirm_twofactor'
      put 'disable_twofactor'
      get 'favorites'
      get 'creations'
      post 'subscribe'
      delete 'unsubscribe'
    end
  end

  resources :collections do
    get :mine, on: :collection
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
      collection do
        get 'live'
      end
    end
  end

  #################
  # BROWSE ROUTES #
  #################

  ########################
  # SINGLE ACTION ROUTES #
  ########################
  get 'settings', to: "users#edit"

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
  get 'commissions_plan', to: "static_stuff#commissions_plan"
  get 'settings', to: 'users#edit'
  post 'settings', to: 'users#update'

  get 'search', to: "images#search"

end
