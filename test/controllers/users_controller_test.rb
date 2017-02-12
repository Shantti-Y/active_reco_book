require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

   def setup
      @submitted_employee = users(:submitted_employee)
      login_as(@submitted_employee)
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
      get user_path(@submitted_employee)
      assert_response :success
   end

   test "should get edit" do
      get edit_user_path(@submitted_employee)
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
      patch user_path(@submitted_employee), params: { user: {
                                                   division: "営業部企画課",
                           # REVIEW : Solve the puzzle why datetime instance variables are needed
                           # =>       for patch request. Without them, the test will be failed.
                                                   started_at:  1.year.ago,
                                                   birthday: 24.year.ago
                                                   } }
      assert_equal "営業部企画課", @submitted_employee.reload.division
      assert flash['success']
      assert_redirected_to home_url
   end

   test "should be failed to update the user with invalid parameters" do
      patch user_path(@submitted_employee), params: { user: {
                                                   division: "a" * 51,
                                                   started_at:  1.year.ago,
                                                   birthday: 24.year.ago
                                                   } }
      assert_not_equal "a" * 51, @submitted_employee.reload.division
      assert flash['danger']
      assert_response :success
   end

   test "should destroy the user" do
      assert_difference 'User.count', -1 do
         delete user_path(@submitted_employee)
      end
         assert_redirected_to home_url
   end

   test "should get edit password" do
      get edit_password_path(@submitted_employee)
      assert_response :success
   end

   test "should change user password" do
      patch update_password_path(@submitted_employee), params: { password: {
                                                            current_password:       'password',
                                                            new_password:           'newpassword',
                                                            password_confirmation:  'newpassword'
                                                         }}
      assert_not_equal @submitted_employee.password_digest, @submitted_employee.reload.password_digest
      assert_not @submitted_employee.reload.password_reset?
      assert flash[:success]
      assert_redirected_to home_url
   end

   test "should not change user password with invalid information" do
      # Stack at the validation in its model
      @submitted_employee.update_attribute(:password_reset, true)
      patch update_password_path(@submitted_employee), params: { password: {
                                                            current_password:       'password',
                                                            new_password:           'newpass',
                                                            password_confirmation:  'newpass'
                                                         }}
      assert @submitted_employee.reload.password_reset?
      assert flash[:danger]
      assert_template 'users/edit_password'

      # Unmatch parameters
      patch update_password_path(@submitted_employee), params: { password: {
                                                            current_password:       'passwords',
                                                            new_password:           'newpassword',
                                                            password_confirmation:  'newpassword'
                                                         }}
      assert @submitted_employee.reload.password_reset?
      assert flash[:danger]
      assert_template 'users/edit_password'

      patch update_password_path(@submitted_employee), params: { password: {
                                                            current_password:       'password',
                                                            new_password:           'newpassword',
                                                            password_confirmation:  'newpasswords'
                                                         }}
      assert @submitted_employee.reload.password_reset?
      assert flash[:danger]
      assert_template 'users/edit_password'

   end

end
