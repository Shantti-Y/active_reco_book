require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
      login_as(@employee)
   end

   test "should get index" do
      get users_path
      assert_response :success
   end

   test "should get new" do
      get new_user_path
      assert_response :success
   end

   test "should get show" do
      get user_path(@employee)
      assert_response :success
   end

   test "should get show via ajax" do
      get user_path(@employee), xhr: true
      assert_response :success
   end

   test "should get edit" do
      get edit_user_path(@employee)
      assert_response :success
   end

   test "should create the user" do
      assert_difference 'User.count', 1 do
        post users_path, params: { user: {
                                         name: "例得　新",
                                         email: "example@youtube.mail.jp",
                                         employee_number: 12345678,
                                         division: "技術部研究開発課",
                                         gender: "女",
                                         started_at: 1.year.ago,
                                         birthday: 24.years.ago,
                                         employee: true,
                                         password: "password",
                                         password_confirmation: "password"
                                         } }
      end
      assert flash['success']
      assert_redirected_to home_url
   end

   test "should not create a user with invalid information" do
      assert_no_difference 'User.count' do
         post users_path, params: { user: {
                                          name: "",
                                          email: ("a" * 255)+ "@.mail.jp",
                                          employee_number: 123456789,
                                          division: "a" * 51,
                                          gender: "両",
                                          started_at: 1.year.ago,
                                          birthday: 24.years.ago,
                                          employee: true,
                                          password: "",
                                          password_confirmation: ""
                                          } }
      end
      assert flash['danger']
      assert_template 'users/new'
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

   test "should get edit password" do
      get edit_password_path(@employee)
      assert_response :success
   end

   test "should change user password" do
      patch update_password_path(@employee), params: { password: {
                                                            current_password:       'password',
                                                            new_password:           'newpassword',
                                                            password_confirmation:  'newpassword'
                                                         }}
      assert_not_equal @employee.password_digest, @employee.reload.password_digest
      assert_not @employee.reload.password_reset?
      assert flash[:success]
      assert_redirected_to home_url
   end

   test "should not change user password with invalid information" do
      # Stack at the validation in its model
      @employee.update_attribute(:password_reset, true)
      patch update_password_path(@employee), params: { password: {
                                                            current_password:       'password',
                                                            new_password:           'newpass',
                                                            password_confirmation:  'newpass'
                                                         }}
      assert @employee.reload.password_reset?
      assert flash[:danger]
      assert_template 'users/edit_password'

      # Unmatch parameters
      patch update_password_path(@employee), params: { password: {
                                                            current_password:       'passwords',
                                                            new_password:           'newpassword',
                                                            password_confirmation:  'newpassword'
                                                         }}
      assert @employee.reload.password_reset?
      assert flash[:danger]
      assert_template 'users/edit_password'

      patch update_password_path(@employee), params: { password: {
                                                            current_password:       'password',
                                                            new_password:           'newpassword',
                                                            password_confirmation:  'newpasswords'
                                                         }}
      assert @employee.reload.password_reset?
      assert flash[:danger]
      assert_template 'users/edit_password'

   end

end
