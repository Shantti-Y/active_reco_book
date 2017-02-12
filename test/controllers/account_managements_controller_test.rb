require 'test_helper'

class AccountManagementsControllerTest < ActionDispatch::IntegrationTest
   def setup
      @employee = User.create!(
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
                               )
   end

   # Account activation action
   test "should get account activation by not activated user" do
      get account_activation_path(id: @employee.activate_token, email: @employee.email)
      assert @employee.reload.activated?
      assert flash[:info]
      assert_redirected_to home_url
   end

   test "should not get account activation with wrong information" do
      # By activated user
      @employee.update_attribute(:activated, true)
      get account_activation_path(id: @employee.activate_token, email: @employee.email)
      assert flash[:danger]
      assert_redirected_to login_url

      @employee.update_attribute(:activated, false)

      # Invalid information
      get account_activation_path(id: @employee.activate_token, email: "example@invalid.mail.jp")
      assert_not @employee.reload.activated?
      assert flash[:danger]
      assert_redirected_to login_url

      get account_activation_path(id: "invalid_token", email: @employee.email)
      assert_not @employee.reload.activated?
      assert flash[:danger]
      assert_redirected_to login_url
   end

   # Password reset new action
   test "should get password reset new" do
      get password_reset_path
      assert_response :success
   end

   # Password reset create action
   test "should post password reset" do
      @employee.update_attribute(:activated, true)
      post password_reset_path, params: {password_reset: {
                                                      email:            @employee.email,
                                                      employee_number:  @employee.employee_number
                                                      }}
      assert flash[:success]
      assert @employee.reload.password_reset?
      assert_redirected_to home_url
   end

   test "should not post password reset with wrong information" do
      @employee.update_attribute(:activated, true)
      @employee.update_attribute(:password_reset, false)

      # Invalid information
      post password_reset_path, params: {password_reset: {
                                                      email:            @employee.email,
                                                      employee_number:  11111111
                                                      }}
      assert flash[:danger]
      assert_not @employee.reload.password_reset?
      assert_template 'account_managements/password_reset_new'

      post password_reset_path, params: {password_reset: {
                                                      email:            "example@invalid.mail.jp",
                                                      employee_number:  @employee.employee_number
                                                      }}
      assert flash[:danger]
      assert_not @employee.reload.password_reset?
      assert_template 'account_managements/password_reset_new'
   end
end
