require 'test_helper'

class AccountManagementsControllerTest < ActionDispatch::IntegrationTest
   def setup
      @unsubmitted_employee = User.create!(
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
       @submitted_employee = User.create!(
                                          name: "例得　古",
                                          email: "example@facebook.mail.jp",
                                          employee_number: 12345678,
                                          division: "技術部研究開発課",
                                          gender: "男",
                                          started_at: 1.year.ago,
                                          birthday: 24.years.ago,
                                          employee: true,
                                          password: "password",
                                          password_confirmation: "password",
                                          activated: true,
                                          password_reset: false
                                          )
   end

   # Account activation action
   test "should get account activation by not activated user" do
      get account_activation_path(id: @unsubmitted_employee.activate_token, email: @unsubmitted_employee.email)
      assert @unsubmitted_employee.reload.activated?
      assert flash[:info]
      assert_redirected_to home_url
   end

   test "should not get account activation with wrong information" do

      # By activated user
      get account_activation_path(id: @submitted_employee.activate_token, email: @submitted_employee.email)
      assert flash[:danger]
      assert_redirected_to login_url

      # Invalid information
      get account_activation_path(id: @unsubmitted_employee.activate_token, email: "example@invalid.mail.jp")
      assert_not @unsubmitted_employee.reload.activated?
      assert flash[:danger]
      assert_redirected_to login_url

      get account_activation_path(id: "invalid_token", email: @unsubmitted_employee.email)
      assert_not @unsubmitted_employee.reload.activated?
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
      post password_reset_path, params: {password_reset: {
                                                      email:            @submitted_employee.email,
                                                      employee_number:  @submitted_employee.employee_number
                                                      }}
      assert flash[:success]
      assert @submitted_employee.reload.password_reset?
      assert_redirected_to home_url
   end

   test "should not post password reset with wrong information" do

      # Invalid information
      post password_reset_path, params: {password_reset: {
                                                      email:            @submitted_employee.email,
                                                      employee_number:  11111111
                                                      }}
      assert flash[:danger]
      assert_not @submitted_employee.password_reset?
      assert_template 'account_managements/password_reset_new'

      post password_reset_path, params: {password_reset: {
                                                      email:            "example@invalid.mail.jp",
                                                      employee_number:  @submitted_employee.employee_number
                                                      }}
      assert flash[:danger]
      assert_not @submitted_employee.password_reset?
      assert_template 'account_managements/password_reset_new'
   end
end
