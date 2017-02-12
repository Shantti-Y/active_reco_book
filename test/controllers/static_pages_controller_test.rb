require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
      login_as(@employee)
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
