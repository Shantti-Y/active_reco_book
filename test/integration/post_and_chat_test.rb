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
      first_posts_count = Post.count
      assert_select '.post', first_posts_count

      get new_post_path, xhr: true
      assert_select_jquery :prepend, 'body' do
         assert_select '#blackout'
         assert_select '#post-form'
      end
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
      # TODO find an alternative way to assert tag selection instead of sending get request
      get home_path
      assert_select '#post-form', 0
      assert_select '#blackout', 0
      assert_select '.post', first_posts_count + 1

      logout_as(@employee)

      # Comment by an employer
      login_as(@employer)
      get home_path

      first_comments_count = post.comments.count
      get new_comment_path(post), xhr: true
      # TODO add jquery selector assertion if comments and form appeared

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
