require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:first_employee)
   end

   test "should get new" do
       get login_path
       assert_response :success
   end

   test "should log in " do
      post login_path, params: { session: { email: @employee.email,
                                             password: "password" }}
      assert_redirected_to home_url
      assert is_logged_in?
   end

   test "should log out" do
      delete logout_path
      assert_redirected_to login_url
      assert_not is_logged_in?
   end

end
