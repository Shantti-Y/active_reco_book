module SessionsHelper

   def current_user
      @current_user || User.find_by(id: session['user_id'])
   end

   def is_logged?
      !current_user.nil?
   end

   def login(user)
      session[:user_id] = user.id
   end

   def logout
      session.delete(:user_id)
      @current_user = nil
   end
end
