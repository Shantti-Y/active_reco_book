class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include UploadersHelper
  include SessionsHelper
  include PostsHelper

  def is_logged_in?
     unless is_logged?
        redirect_to login_url
     end
  end

end
