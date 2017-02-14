require 'test_helper'

class ReactionsControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
      @employer = users(:employer)
      @post = posts(:morning)
   end

   test "should create reaction" do
      login_as(@employer)
      assert_difference 'Reaction.count', 1 do
         get new_reaction_path(@post), xhr: true
      end
      assert_response :success
   end

   test "should destroy reaction" do
      login_as(@employee)
      assert_difference 'Reaction.count', -1 do
        delete reaction_path(@post), xhr: true
      end
      assert_response :success
   end
end
