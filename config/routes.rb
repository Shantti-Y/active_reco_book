Rails.application.routes.draw do

   # Routes for static pages
   get '/home', to: 'static_pages#home'
   get '/search_home', to: 'static_pages#search_home'
   get '/help', to: 'static_pages#help'
   get '/about', to: 'static_pages#about'
   get '/convention', to: 'static_pages#convention'

   # Routes for users
   # TODO Need to rename http parameters when the time to create HR page comes
   resources 'users'
   get 'users/:id/edit_password', to: 'users#edit_password', as: 'edit_password'
   patch 'users/:id/edit_password', to: 'users#update_password', as: 'update_password'
   get 'search_user/:id', to: 'users#search_user', as: 'search_user'

   # Routes for sessions
   get '/login', to: 'sessions#new'
   post '/login', to: 'sessions#create'
   delete '/logout/:id', to: 'sessions#destroy', as: 'logout'

   # Routes for account managements
   get '/account_activation/:id', to: 'account_managements#account_activation', as: 'account_activation'
   get '/password_reset', to: 'account_managements#password_reset_new'
   post '/password_reset', to: 'account_managements#password_reset_create'

   # Routes for file uploaders
   resources 'uploaders', only: [] do
     member do
      get :user_thumbnail, as: :user_thumbnail
     end
   end

   # Routes for posts
   resources 'posts', only: [:new, :show, :edit, :create, :update, :destroy]

   # Routes for comments
   resources 'comments', only: [:edit, :create, :update, :destroy]
   get '/comments/:id', to: 'comments#new', as: 'new_comment'

   # Routes for reactions
   resources 'reactions', only: [:destroy]
   get '/reactions/:id', to: 'reactions#create', as: "new_reaction"

   resources 'conditions', only: [:show, :edit, :create, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
