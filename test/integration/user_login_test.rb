require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:first_employee)
   end

   test "session expiration" do
      # Session should be deleted after the limited term without remember status
      login_as(@employee)
      expired_term = Time.zone.now + 3.days
      Timecop.travel(expired_term) do
         assert_not is_logged_in?
      end

      # Session could exist with the remember status
      Timecop.return
      login_as(@employee, "password", "1")
      Timecop.travel(expired_term) do
         assert is_logged_in?
      end
   end
end
