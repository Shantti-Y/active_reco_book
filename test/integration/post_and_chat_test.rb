require 'test_helper'

class PostAndChatTest < ActionDispatch::IntegrationTest
   def setup
      @employee = users(:employee)
      @another_employee = users(:another_employee)
      @employer = users(:employer)
   end


   test "daily post and comment" do
      # Post something
      login_as(@employee)
      get home_path
      first_posts_count = Post.where(published: true).count
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

   test "draft management" do
      # Show drafts
      login_as(@employee)
      get user_path(@employee)
      published_posts_count = Post.where(published: true).count
      assert_select '#toggled-publish.toggle-active'
      assert_select '.post', published_posts_count

      get user_path(@employee, published: "0"), xhr: true
      assert_select_jquery :html, '#posts' do
         draft_posts_count = Post.where(published: false).count
         assert_select '.post', draft_posts_count
      end
      assert_select '#toggled-draft.toggle-active'

      get user_path(@employee), xhr: true
      assert_select_jquery :html, '#posts' do
         assert_select '.post', published_posts_count
      end
      assert_select '#toggled-publish.toggle-active'

      # Unable to switch when other user login
      login_as(@another_employee)
      get user_path(@employee)
      assert_select '#search-another-user'
      assert_select '#toggle-draft', 0

      # Unable to comment to draft posts
      login_as(@employee)
      get user_path(@employee), xhr: true
      assert_select_jquery :html, '#posts' do
         assert_select '.post', published_posts_count
      end
      assert_select '.post-reaction', 0

      @draft = posts(:draft)
      assert_no_difference 'Comment.count' do
         post comments_path, xhr: true, params: { comment: {
                                                           post_id: @draft.id,
                                                           content: "Hello, are you good?"
                                                           }}
      end
      assert_not flash[:success]
      assert_template 'comments/create'
   end
end
