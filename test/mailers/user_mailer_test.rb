require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
   def setup
      @unsubmitted_employee = users(:unsubmitted_employee)
      @employee = users(:first_employee)
   end

   test "account_activation" do
      mail = UserMailer.account_activation(@unsubmitted_employee)
      @unsubmitted_employee.activate_token = User.new_token

      assert_equal "アカウント登録のご案内", mail.subject
      assert_equal [@unsubmitted_employee.email], mail.to
      assert_equal ["info@activerecobook.co.jp"], mail.from

      # TODO Need to add the regexp assertion for mail context (Unable to set because of the encode)
   end

   test "password_reset" do
      mail = UserMailer.password_reset(@employee)
      @employee.password_reset_token = User.new_token

      assert_equal "パスワード再発行のご案内", mail.subject
      assert_equal [@employee.email], mail.to
      assert_equal ["info@activerecobook.co.jp"], mail.from
   end

end
