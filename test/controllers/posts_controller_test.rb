require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
      @morning = posts(:morning)
      login_as(@employee)
   end

   test "should get new" do
      get new_post_path, xhr: true
      assert_response :success
   end

   test "should get show" do
      get post_path(@morning), xhr: true
      assert_response :success
   end

   test "should get edit" do
      get edit_post_path(@morning), xhr: true
      assert_response :success
   end

   test "should create new post" do
      assert_difference 'Post.count', 1 do
         post posts_path, xhr: true, params: { post: {
                                                     content: "Hello world",
                                                     condition: "info",
                                                     post_type: "daily",
                                                     published: true
                                                     }}
      end
      assert flash[:success]
      assert_template 'posts/create'
   end

   test "should not create new post with invalid information" do
      assert_no_difference 'Post.count', 1 do
         post posts_path, xhr: true, params: { post: {
                                                     content: "",
                                                     condition: "inf",
                                                     post_type: "dail"
                                                     }}
      end
      assert_not flash[:success]
      assert_template 'posts/create'
   end

   test "should update the post" do
      patch post_path(@morning), xhr: true, params: { post: {
                                                             content: "Hello world",
                                                             condition: "info",
                                                             post_type: "daily"
                                                             }}
      assert_equal "Hello world", @morning.reload.content
      assert flash[:success]
      assert_template 'posts/update'
   end

   test "should not update the post with invalid information" do
      patch post_path(@morning), xhr: true, params: { post: {
                                                             content: "",
                                                             condition: "inf",
                                                             post_type: "dail"
                                                             }}
      assert_not_equal "Hello world", @morning.reload.content
      assert_not flash[:success]
      assert_template 'posts/update'
   end

   test "should destroy the post" do
      assert_difference "Post.count", -1 do
         delete post_path(@morning)
      end
      assert flash[:info]
      assert_redirected_to home_url
   end
end
