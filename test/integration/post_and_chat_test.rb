require 'test_helper'

class PostAndChatTest < ActionDispatch::IntegrationTest
   def setup
      @employee = users(:employee)
      @employer = users(:employer)
   end


   test "daily post and comment" do
      # Post something
      login_as(@employee)
      get home_path
      get new_post_path, xhr: true
      assert_difference 'Post.count', 1 do
         post posts_path, xhr: true, params: { post: {
                                                    content: "Hello, are you good?",
                                                    condition: "info",
                                                    post_type: 'daily'
                                                    }}
      end
      post = assigns(:post)
      assert flash[:success]
      assert_template 'posts/create'

      logout_as(@employee)

      # Comment by an employer
      login_as(@employer)
      get home_path
      get new_comment_path(post), xhr: true
      assert_difference 'Comment.count', 1 do
         post comments_path, xhr: true, params: { comment: {
                                                           post_id: post.id,
                                                           content: "Hello, are you good?"
                                                           }}
      end
      assert flash[:success]
      assert_template 'comments/create'
   end
end
