require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:first_employee)
      login_as(@employee)
   end

   test "should get index" do
      get users_path
      assert_response :success
   end

   test "should get show" do
      get user_path(@employee)
      assert_response :success
   end

   test "should get new" do
      get new_user_path
      assert_response :success
   end

   test "should get edit" do
      get edit_user_path(@employee)
      assert_response :success
   end

   test "should update the user" do
      patch user_path(@employee), params: { user: {
                                                   division: "営業部企画課",
                           # REVIEW : Solve the puzzle why datetime instance variables are needed
                           # =>       for patch request. Without them, the test will be failed.
                                                   started_at:  1.year.ago,
                                                   birthday: 24.year.ago
                                                   } }
      assert_equal "営業部企画課", @employee.reload.division
      assert flash['success']
      assert_redirected_to home_url
   end

   test "should be failed to update the user with invalid parameters" do
      patch user_path(@employee), params: { user: {
                                                   division: "a" * 51,
                                                   started_at:  1.year.ago,
                                                   birthday: 24.year.ago
                                                   } }
      assert_not_equal "a" * 51, @employee.reload.division
      assert flash['danger']
      assert_response :success
   end

   test "should destroy the user" do
      assert_difference 'User.count', -1 do
         delete user_path(@employee)
      end
         assert_redirected_to home_url
   end

end
