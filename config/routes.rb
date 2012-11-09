StoneboatpotteryCa::Application.routes.draw do

  root :to => 'posts#index'

  resources :categories, :only => [:index, :show] do
    resources :subcategories, :only => [:show] do
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
  resources :paper_pieces, :only => [:index, :show]

  match 'about' => 'blocks#about'
  match 'contact' => 'blocks#contact'

  resources :links, :only => [:index]

  namespace :admin do
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

    resources :links

    resources :functional_pieces
    resources :sculptural_pieces
    resources :paper_pieces

    resources :users, :only => [:edit, :update]

    resources :images, :only => [:create, :new, :destroy] do
      member do
        put :make_primary
      end
    end

    resources :categories do
      resources :subcategories, :only => [:new, :show, :create, :update, :edit, :destroy] do
        resources :forms, :only => [:new, :show, :create, :update, :edit, :destroy]
      end
    end

  end

end
