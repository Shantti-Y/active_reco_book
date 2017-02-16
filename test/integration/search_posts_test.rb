require 'test_helper'

class SearchPostsTest < ActionDispatch::IntegrationTest
   def setup
      @employee = users(:employee)
      login_as(@employee)
   end

   test "search post with specified word" do
      # Search on the home path
      get home_path
      get search_home_path, xhr: true, params: { post: { word: "morning" } }
      assert_select_jquery :html, '#posts' do
         assert_select '.post', 1
      end

      get search_home_path, xhr: true, params: { post: { word: "unfound words" } }
      assert_select_jquery :html, '#posts' do
         assert_select '.post', 0
      end

      # Search on the user path
      get user_path(@employee)
      get search_user_path(@employee), xhr: true, params: { post: { word: "morning" } }
      assert_select_jquery :html, '#posts' do
         assert_select '.post', 1
      end

      get search_user_path(@employee), xhr: true, params: { post: { word: "unfound words" } }
      assert_select_jquery :html, '#posts' do
         assert_select '.post', 0
      end

      get search_user_path(@employee), xhr: true, params: { post: { word: "draft", published: "0" } }
      assert_select_jquery :html, '#posts' do
         assert_select '.post', 1
      end
   end
end
