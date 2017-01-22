ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def is_logged_in?
     if !session[:user_id].nil?
        user = User.find(session[:user_id])
        if user.authenticated?('remember', cookies[:remember_token])
           remember(user)
           return true
        elsif session[:expired_at] <= Time.now
            logout_as
            return false
        else
            return true
        end
     end
  end

  def login_as(user)
     session[:user_id] = user.id
     session[:expired_at] = Time.now + 3.days
  end


  def logout_as
     session.delete(:user_id)
  end

  class ActionDispatch::IntegrationTest
    def login_as(user, password: 'password')
      post login_path, params: { session: { email: user.email,
                                           password: password } }
    end
  end
end
