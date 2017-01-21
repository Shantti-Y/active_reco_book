require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:first_employee)
   end

   test "session expiration" do
      # Session should be deleted after the limited term without remember status
      login_as(@employee)
      expired_term = Time.now + 3.days
      Timecop.travel(expired_term)

      assert_not is_logged_in?

      # Session could exist with the remember status
      Timecop.return
      post login_path, params: { session: { email: @employee.email,
                                             password: "password",
                                             remembered: "1" }}
      Timecop.travel(expired_term)
      assert is_logged_in?
   end
end
