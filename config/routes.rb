Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/show'

  get 'posts/edit'

   # Routes for static pages
   get '/home', to: 'static_pages#home'
   get '/help', to: 'static_pages#help'
   get '/about', to: 'static_pages#about'
   get '/convention', to: 'static_pages#convention'

   # Routes for users
   # TODO Need to rename http parameters when the time to create HR page comes
   resources 'users'
   get 'users/:id/edit_password', to: 'users#edit_password', as: 'edit_password'
   patch 'users/:id/edit_password', to: 'users#update_password', as: 'update_password'

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
   resources 'posts'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
