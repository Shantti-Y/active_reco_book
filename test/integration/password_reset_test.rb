require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest
   def setup
      @employee = users(:first_employee)
      ActionMailer::Base.deliveries.clear
   end

   test "password reset" do
      # Send the password reset email
      get password_reset_path
      post password_reset_path, params: { password_reset: {
                                                            email: @employee.email,
                                                            employee_number: @employee.employee_number
                                                          } }
      assert flash['success']
      assert_redirected_to home_url
      assert_equal 1, ActionMailer::Base.deliveries.size
      assert_not @employee.reload.password_reset_sent_at.nil?
      assert @employee.reload.password_reset?

      # Unable to login with expired password
      expired_term = Time.zone.now + 3.weeks
      Timecop.travel(expired_term) do
         login_as(@employee)
         assert_not is_logged_in?
      end

      # Login in the limited terms
      Timecop.return
      login_as(@employee)
      assert is_logged_in?

      # Postpone to change the password until it is expired
      logout_as(@employee)

      Timecop.travel(expired_term) do
         login_as(@employee)
         assert_not is_logged_in?
      end


      # Change the password in the limited terms
      Timecop.return
      login_as(@employee)
      patch update_password_path(@employee), params: { password: {
                                                                  current_password: "password",
                                                                  new_password: "newpassword",
                                                                  password_confirmation: "newpassword"
                                                      } }
      assert flash['success']
      assert_not @employee.reload.password_reset?

      logout_as(@employee)
      Timecop.travel(expired_term) do
         login_as(@employee, "newpassword")
         assert is_logged_in?
      end


   end

end
