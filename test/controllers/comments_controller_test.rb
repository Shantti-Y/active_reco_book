require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
      @morning = posts(:morning)
      @re_morning = comments(:re_morning)
      login_as(@employee)
   end

   test "should get new" do
      get new_comment_path(@morning), xhr: true
      assert_response :success
   end

   test "should get edit" do
      get edit_comment_path(@re_morning), xhr: true
      assert_response :success
   end

   test "should create new comment" do
      assert_difference 'Comment.count', 1 do
         post comments_path, xhr: true, params: { comment: {
                                                           post_id: @morning.id,
                                                           content: "I'm fine"
                                                           }}
      end
      assert flash[:success]
      assert_template 'comments/create'
   end

   test "should not update new comment with invalid information" do
      assert_no_difference 'Comment.count' do
         post comments_path, xhr: true, params: { comment: {
                                                           post_id: @morning.id,
                                                           content: ""
                                                           }}
      end
      assert_not flash[:success]
      assert_template 'comments/create'
   end

   test "should update the comment" do
      patch comment_path(@re_morning), xhr: true, params: { comment: { content: "Soso..." }}
      assert_equal "Soso...", @re_morning.reload.content
      assert flash[:success]
      assert_template 'comments/update'
   end

   test "should not update the comment with invalid information" do
      patch comment_path(@re_morning), xhr: true, params: { comment: { content: "" }}
      assert_not_equal "Soso...", @re_morning.reload.content
      assert_not flash[:success]
      assert_template 'comments/update'
   end

   test "should destroy the comment" do
      assert_difference 'Comment.count', -1 do
         delete comment_path(@re_morning)
      end
      assert flash[:info]
      assert_redirected_to home_url
   end
end
