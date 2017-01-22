Rails.application.routes.draw do
   # Routes for static pages
   get '/home', to: 'static_pages#home'
   get '/help', to: 'static_pages#help'
   get '/about', to: 'static_pages#about'
   get '/convention', to: 'static_pages#convention'

   # Routes for users
   # TODO Need to rename http parameters when the time to create HR page comes
   resources 'users'

   # Routes for sessions
   get '/login', to: 'sessions#new'
   post '/login', to: 'sessions#create'
   delete '/logout/:id', to: 'sessions#destroy', as: 'logout'

   # Routes for account managements
   get '/account_activation/:id', to: 'account_managements#account_activation', as: 'account_activation'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
