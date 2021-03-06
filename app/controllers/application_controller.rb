class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include UploadersHelper
  include SessionsHelper
  include PostsHelper
  include ConditionsHelper
  include QuestionsHelper

  def is_logged_in?
     unless is_logged?
        redirect_to login_url
     end
  end

  def url_log
    store_location
  end

end
