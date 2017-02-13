require 'test_helper'

class CommentTest < ActiveSupport::TestCase

   def setup
      @employee = users(:employee)
      @employer = users(:employer)
      @post = posts(:morning)
      @draft = posts(:draft)
      @comment = Comment.new(
                              user_id: @employee.id,
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

   test "should not be related to draft" do
      @comment.post = @draft
      assert_not @comment.valid?
   end

   test "comments should be destroyed when relative user deleted" do
      @employee.destroy
      assert_equal 0, @employee.comments.count
   end

   test "comments should be destroyed when relative post deleted" do
      @post.destroy
      assert_equal 0, @post.comments.count
   end
end
