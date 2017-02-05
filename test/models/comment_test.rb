require 'test_helper'

class CommentTest < ActiveSupport::TestCase

   def setup
      @employee = users(:first_employee)
      @employer = users(:employer)
      @post = posts(:morning)
      @comment = Comment.new(
                              user_id: @employer.id,
                              post_id: @post.id,
                              content: "Hello, how are you?"
                            )
   end

   test "should be valid" do
      assert @comment.valid?
   end

   test "user id should be present" do
      @comment.user_id = ""
      assert_not @comment.valid?
   end

   test "post id should be present" do
      @comment.user_id = ""
      assert_not @comment.valid?
   end

   test "content should be present" do
      @comment.content = ""
      assert_not @comment.valid?
   end

   test "content should have less than 100 chars" do
      @comment.content = "a" * 1001
      assert_not @comment.valid?
   end
end
