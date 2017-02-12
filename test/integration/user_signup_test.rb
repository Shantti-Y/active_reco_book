require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
     ActionMailer::Base.deliveries.clear
     @employee = users(:employee)
     login_as(@employee)
  end

  test "unable to sign up with invalid information" do
     get new_user_path
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
     # TODO add the selector assertion after web design determined
  end

  test "sign up with valid information and activate the account" do
     get new_user_path
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
     assert_equal 1, ActionMailer::Base.deliveries.size
     user = assigns(:user)
     assert_not user.activated?
     logout_as(@employee)

     # Try to login before activated
     login_as(user)
     assert_not is_logged_in?

     # Invalid activation token
     get account_activation_path(id: 'Invalid token', email: user.email)
     assert_not is_logged_in?

     # Invalid email address
     get account_activation_path(id: user.activate_token, email: 'mail.org')
     assert_not is_logged_in?

     # Succeed to activate
     get account_activation_path(id: user.activate_token, email: user.email)
     assert is_logged_in?
     assert user.reload.activated?
     assert_redirected_to home_url
  end
end
