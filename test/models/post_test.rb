require 'test_helper'

class PostTest < ActiveSupport::TestCase

   def setup
      @employee = users(:employee)
      @post = Post.new(
                        user_id: @employee.id,
                        content: "Welcome and hello world!!",
                        condition: "success",
                        post_type: "daily",
                        published: true
                      )
   end

   test "should be valid" do
      assert @post.valid?
   end

   test "user id should be present" do
      @post.user_id = ""
      assert_not @post.valid?
   end

   test "content should be present" do
      @post.content = ""
      assert_not @post.valid?
   end

   test "content should have less than 100 chars" do
      @post.content = "a" * 1001
      assert_not @post.valid?
   end

   test "condition should be correct with proper formats" do
      valid_conditions = %w[blank, success, info, warning, danger]
      valid_conditions.each do |condition|
         @post.condition = condition
         assert @post.valid?
      end
   end

   test "condition should not be correct with improper formats" do
      invalid_conditions = %w[blak, confort, sate, causion, gander]
      invalid_conditions.each do |condition|
         @post.condition = condition
         assert_not @post.valid?
      end
   end

   test "post type should be correct with proper formats" do
      valid_post_type = %w[daily, condition, learning]
      valid_post_type.each do |type|
         @post.post_type = type
         assert @post.valid?
      end
   end

   test "post type should not be correct with improper formats" do
      invalid_post_type = %w[weekly, condision, learnshite]
      invalid_post_type.each do |type|
         @post.post_type = type
         assert_not @post.valid?
      end
   end

   test "post should be destroyed when relative user deleted" do
      @employee.destroy
      assert_equal 0, @employee.posts.count
   end
end
