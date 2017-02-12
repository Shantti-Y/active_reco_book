require 'test_helper'

class CommentTest < ActiveSupport::TestCase

   def setup
      @submitted_employee = users(:submitted_employee)
      @employer = users(:employer)
      @post = posts(:morning)
      @comment = Comment.new(
                              user_id: @submitted_employee.id,
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

   test "comments should be destroyed when relative user deleted" do
      @submitted_employee.destroy
      assert_equal 0, @submitted_employee.comments.count
   end

   test "comments should be destroyed when relative post deleted" do
      @post.destroy
      assert_equal 0, @post.comments.count
   end
end
