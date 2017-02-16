require 'test_helper'

class ConditionTest < ActiveSupport::TestCase

   def setup
      @employee = users(:employee)
      @post = Post.create(
                        user_id: @employee.id,
                        content: "Posted his condition",
                        condition: "blank",
                        post_type: "condition",
                        published: true
                       )
      @condition = Condition.new(
                                 user_id: @employee.id,
                                 post_id: @post.id,
                                 category: 1,
                                 point: 0
                                 )
   end

   test "should be valid" do
      assert @condition.valid?
   end

   test "should be associated with the relative question" do
      question = Question.find_by(category: @condition.category)
      assert_equal "What are you doing?", question.content
   end

   test "user id should be present" do
      @condition.user_id = ""
      assert_not @condition.valid?
   end

   test "post id should be present" do
      @condition.post_id = ""
      assert_not @condition.valid?
   end

   test "category should be present" do
      @condition.category = ""
      assert_not @condition.valid?
   end

   test "point should be present" do
      @condition.point = ""
      assert_not @condition.valid?
   end

   test "should be destroyed when relative user deleted" do
      @employee.destroy
      assert_equal 0, @employee.conditions.count
   end

   test "should be destroyed when relative post deleted" do
      @post.destroy
      assert_equal 0, @post.conditions.count
   end
end
