require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
   end

   test "should get new" do
       get login_path
       assert_response :success
       assert_not is_logged_in?
   end

   test "should log in" do
      post login_path, params: { session: { email: @employee.email,
                                             password: "password" }}
      assert flash[:info]
      assert_redirected_to home_url
      assert is_logged_in?
   end

   test "should be failed to log in with invalid condition" do
      # Posting invalid information
      post login_path, params: { session: { email: "invalid email",
                                             password: "password" }}
      assert flash['danger']
      assert_template 'sessions/new'
      assert_not is_logged_in?

      post login_path, params: { session: { email: @employee.email,
                                             password: "invalid_password" }}
      assert flash['danger']
      assert_template 'sessions/new'
      assert_not is_logged_in?

      # Trying to log in invalid condition
      @employee.update_attribute(:activated, false)
      post login_path, params: { session: { email: @employee.email,
                                             password: "password" }}
      assert flash['danger']
      assert_template 'sessions/new'
      assert_not is_logged_in?

      @employee.update_attribute(:activated, true)

      @employee.update_attribute(:password_reset, true)
      expired_term = Time.zone.now + 3.weeks
      Timecop.travel(expired_term) do
         post login_path, params: { session: { email: @employee.email,
                                                password: "password" }}
         assert flash['danger']
         assert_template 'sessions/new'
         assert_not is_logged_in?
      end
   end

   test "should log out" do
      login_as(@employee)
      delete logout_path(@employee)
      assert_redirected_to login_url
      assert_not is_logged_in?
   end

end
