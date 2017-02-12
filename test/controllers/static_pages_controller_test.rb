require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

   def setup
      @submitted_employee = users(:submitted_employee)
      login_as(@submitted_employee)
   end

   test "should get home" do
      get home_path
      assert_response :success
   end

   test "should get help" do
      get help_url
      assert_response :success
   end

   test "should get about" do
      get about_url
      assert_response :success
   end

   test "should get convention" do
      get convention_url
      assert_response :success
   end
end
