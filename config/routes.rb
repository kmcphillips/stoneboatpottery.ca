ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'posts', :action => 'index'

  map.resources :categories, :only => [:index, :show] do |categories|
    categories.resources :subcategories, :only => [:show] do |subcategories|
      subcategories.resources :forms, :only => [:show]
    end  
  end
  
  map.resources :posts, :only => [:index, :show], :collection => [:archive]
  map.connect 'rss.:format', :controller => 'posts', :action => 'rss'

  map.resources :pieces, :only => [:index, :show]

  map.resources :blocks, :only => [], :collection => [:about_stoneboat, :about_joanna, :contact]
  map.connect 'about_joanna', :controller => 'blocks', :action => 'about_joanna'
  map.connect 'about_stoneboat', :controller => 'blocks', :action => 'about_stoneboat'
  map.connect 'contact', :controller => 'blocks', :action => 'contact'
  map.connect 'wholesale', :controller => 'blocks', :action => 'wholesale'

  map.resources :links, :only => [:index]

  map.resources :sessions, :only => [:index, :new, :create, :destroy], :collection => [:logout]
  map.connect 'login', :controller => 'sessions', :action => 'new'
  map.connect 'logout', :controller => 'sessions', :action => 'logout'

  map.namespace :admin do |admin|
    admin.resources :sessions, :only => [:index, :new, :create, :destroy], :collection => [:logout]
    admin.connect 'login', :controller => 'sessions', :action => 'new'
    admin.connect 'logout', :controller => 'sessions', :action => 'logout'
    
    admin.resources :posts
    admin.connect '/', :controller => 'posts'
    
    admin.resources :blocks, :only => [:index, :show, :update, :edit]

    admin.resources :links

    admin.resources :pieces

    admin.resources :users, :only => [:edit, :update]

    admin.resources :categories do |categories|
      categories.resources :subcategories, :only => [:new, :show, :create, :update, :edit, :destroy] do |subcategories|
        subcategories.resources :forms, :only => [:new, :show, :create, :update, :edit, :destroy]
      end
    end

    admin.resources :images
  end

end
