require 'test_helper'

class ConditionsControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
      @condition = conditions(:first)
      login_as(@employee)
   end

   test "should get show" do
      get condition_path(@employee)
      assert_response :success
   end

   test "should get edit" do
      get edit_condition_path(@condition, question_number: 1)
      assert_response :success
   end

   test "should create new condition" do
      posts(:condition).destroy
      assert_difference 'Post.count', 1 do
         assert_difference 'Condition.count', 10 do
            post new_condition_path
         end
      end
      condition = @employee.posts.where(post_type: "condition").last.conditions.find_by(category: 1)
      assert_redirected_to edit_condition_url(condition, question_number: 1)
   end

   test "should not create new condition when not time to check" do

   end

   test "should update the condition" do
      patch condition_path(@condition, question_number: 1, point: 5)
      assert_equal @condition.point + 5, @condition.reload.point
      assert_redirected_to edit_condition_url(@condition, question_number: 2)
   end

   test "should not update the condition when not time to check" do

   end
end
