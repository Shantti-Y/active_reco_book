module SessionsHelper

   def current_user
      if user_id = session[:user_id]
            @current_user || User.find_by(id: session['user_id'])
      elsif user_id = cookies.signed[:user_id]
         user = User.find_by(id: user_id)
         if user && user.authenticated?('remember', cookies[:remember_token])
            login(user)
            @current_user = user
         end
      end
   end

   def is_logged?
      if !current_user.nil?
         if current_user.authenticated?('remember', cookies.permanent[:remember_token])
               remember(current_user)
               return true
         elsif session[:expired_at] <= Time.now
               logout
               return false
         else
            return true
         end
      end

   end

   def login(user)
      session[:user_id] = user.id
      session[:expired_at] = Time.now + 3.days
   end

   def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
   end

   def logout
      session.delete(:user_id)
      @current_user = nil
   end

   def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
   end

   def store_location
     session.delete(:forwarding_url)
     session[:forwarding_url] = request.original_url if request.get?
   end

   def redirect_back_to(default)
     redirect_to session[:forwarding_url] || default
     session.delete(:forwarding_url)
   end
end
