ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'posts', :action => 'index'

  map.resources :categories, :only => [:index, :show] do |categories|
    categories.resources :subcategories, :only => [:show] do |subcategories|
      subcategories.resources :forms, :only => [:show]
    end  
  end
  
  map.resources :posts, :only => [:index, :show], :collection => [:archive]
  map.connect 'rss.:format', :controller => 'posts', :action => 'rss'

  map.resources :functional_pieces, :only => [:index, :show]

  map.resources :sculptural_pieces, :only => [:index, :show]


  map.resources :blocks, :only => [], :collection => [:about, :contact, :wholesale]
  map.connect 'about', :controller => 'blocks', :action => 'about'
  map.connect 'contact', :controller => 'blocks', :action => 'contact'
  map.connect 'wholesale', :controller => 'blocks', :action => 'wholesale'

  map.resources :links, :only => [:index]

  map.resources :sessions, :only => [:index, :new, :create, :destroy], :collection => [:logout]
  map.connect 'login', :controller => 'sessions', :action => 'new'
  map.connect 'logout', :controller => 'sessions', :action => 'logout'

  map.namespace :admin do |admin|
    admin.resources :sessions, :only => [:index, :new, :create, :destroy], :collection => {:logout => :get, :password => :get, :change_password => :post}
    admin.connect 'login', :controller => 'sessions', :action => 'new'
    admin.connect 'logout', :controller => 'sessions', :action => 'logout'
    
    admin.resources :posts
    admin.connect '/', :controller => 'posts'
    
    admin.resources :blocks, :only => [:index, :show, :update, :edit]

    admin.resources :links

    admin.resources :functional_pieces

    admin.resources :sculptural_pieces

    admin.resources :users, :only => [:edit, :update]

    admin.resources :images, :only => [:create, :new, :destroy], :member => [:make_primary]

    admin.resources :categories do |categories|
      categories.resources :subcategories, :only => [:new, :show, :create, :update, :edit, :destroy] do |subcategories|
        subcategories.resources :forms, :only => [:new, :show, :create, :update, :edit, :destroy]
      end
    end

  end

end
