require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:first_employee)
      @unsubmitted_employee = users(:unsubmitted_employee)
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

   test "should be failed to log in without activation" do
      post login_path, params: { session: { email: @unsubmitted_employee.email,
                                             password: "password" }}
      assert flash['danger']
      assert_template 'sessions/new'
      assert_not is_logged_in?
   end

   test "should log out" do
      login_as(@employee)
      delete logout_path(@employee)
      assert_redirected_to login_url
      assert_not is_logged_in?
   end

end
