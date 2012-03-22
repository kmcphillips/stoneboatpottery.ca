StoneboatpotteryCa::Application.routes.draw do

  root :to => 'posts#index'

  resources :categories, :only => [:index, :show] do
    resources :subcategories, :only => [:show]
      resources :forms, :only => [:show]
    end  
  end
  
  resources :posts, :only => [:index, :show] do
    collection do
      get :archive
    end
  end

  match 'rss.:format' => 'posts#rss'

  resources :functional_pieces, :only => [:index, :show]
  resources :sculptural_pieces, :only => [:index, :show]

  match 'about' => 'blocks#about'
  match 'contact' => 'blocks#contact'
  match 'wholesale' => 'blocks#wholesale'

  resources :links, :only => [:index]

  resources :sessions, :only => [:index, :new, :create, :destroy] do
    collection do
      get :logout
    end
  end

  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#logout'

  namespace :admin
    root :to => 'posts#index'

    resources :sessions, :only => [:index, :new, :create, :destroy] do
      collection do
        get :logout
        get :password
        post :change_password
      end
    end

    match 'login'  => 'sessions#new'
    match 'logout' => 'sessions#logout'
    
    resources :posts
    
    resources :blocks, :only => [:index, :show, :update, :edit]

    resources :wholesale_passwords, :only => [:index, :create, :destroy]

    resources :links

    resources :functional_pieces

    resources :sculptural_pieces

    resources :users, :only => [:edit, :update]

    resources :images, :only => [:create, :new, :destroy] do
      member do
        get :make_primary
      end
    end

    resources :categories do
      resources :subcategories, :only => [:new, :show, :create, :update, :edit, :destroy]
        resources :forms, :only => [:new, :show, :create, :update, :edit, :destroy]
      end
    end

  end

end
