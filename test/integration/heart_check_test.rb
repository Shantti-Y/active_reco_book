require 'test_helper'

class HeartCheckTest < ActionDispatch::IntegrationTest

   def setup
      @employee = users(:employee)
      @another_employee = users(:another_employee)
      @questions = Question.all
      posts(:condition).destroy
   end

   test "monthly heartrate check" do
      check_term = Date.new(Date.today.year, Date.today.month, 15)
      Timecop.travel(check_term)
      login_as(@employee)
      get condition_path(@employee)
      assert_select '#condition-notice'
      assert_select '#condition-title > span', "未回答"
      # checkbox breakdown assertion
      assert_select '#motivation-table .fa-check-square-o', 0
      assert_select '#burden-table .fa-check-square-o', 0
      assert_select '#motivation-table .fa-square-o', 6
      assert_select '#burden-table .fa-square-o', 6
      assert_select '.post-reaction', 0

      expected_results = {
                           exhausted: {
                              point_burden: 1,
                              point_motivation: 1,
                              title: "ヘトヘト",
                              class_title: "exhausted",
                              class_burden: "danger",
                              class_motivation: "danger"
                           },
                           aggressive: {
                              point_burden: 1,
                              point_motivation: 3,
                              title: "ギリギリ",
                              class_title: "aggressive",
                              class_burden: "danger",
                              class_motivation: "warning"
                           },
                           gloomy: {
                              point_burden: 3,
                              point_motivation: 1,
                              title: "モヤモヤ",
                              class_title: "gloomy",
                              class_burden: "warning",
                              class_motivation: "danger"
                           },
                           vivacious: {
                              point_burden: 5,
                              point_motivation: 5,
                              title: "イキイキ",
                              class_title: "vivacious",
                              class_burden: "info",
                              class_motivation: "info"
                           }
                        }

      expected_results.each do |key, expection|
         post new_condition_path
         post = @employee.posts.where(post_type: "condition").order(:created_at).last
         condition = post.conditions.find_by(category: 1)
         assert_redirected_to edit_condition_url(condition, question_number: 1)

         n = 1
         20.times do |i|
            question = @questions.find_by(question_number: n)
            condition = post.conditions.find_by(category: question.category)
            patch condition_path(condition, question_number: n, point: expection[:point_burden])
            n += 1
         end
         20.times do |j|
            question = @questions.find_by(question_number: n)
            condition = post.conditions.find_by(category: question.category)
            patch condition_path(condition, question_number: n, point: expection[:point_motivation])
            n += 1
         end

         assert_redirected_to condition_path(@employee)
         follow_redirect!

         assert_select "#condition-title > span.condition-#{expection[:class_title]}", "#{expection[:title]}"
         # checkbox breakdown assertion
            assert_select "#motivation-table .current.summary-#{expection[:class_motivation]} .fa-check-square-o", 1
            assert_select "#burden-table .current.summary-#{expection[:class_burden]} .fa-check-square-o", 1
            assert_select '#motivation-table .fa-square-o', 5
            assert_select '#burden-table .fa-square-o', 5
         assert_select '.post-reaction'

         posts_count = Post.where(published: true).count - 4
         get home_path
         assert_select '.post', posts_count

         post.destroy
      end
   end

   test "regulated to answer the heartrate check" do

      # Out of duration
      out_of_term = Date.new(Date.today.year, Date.today.month, 1)
      Timecop.travel(out_of_term)
      login_as(@another_employee)
      get condition_path(@another_employee)
      assert_select '#condition-notice', 0

      assert_no_difference 'Post.count' do
         post new_condition_path
      end
      assert flash[:danger]
      assert_redirected_to condition_path(@another_employee)

      Timecop.return

      # After answered
      check_term = Date.new(Date.today.year, Date.today.month, 15)
      Timecop.travel(check_term)
      login_as(@another_employee)
      post new_condition_path
      post = @another_employee.posts.where(post_type: "condition").order(:created_at).last
      condition = post.conditions.find_by(category: 1)
      assert_redirected_to edit_condition_url(condition, question_number: 1)

      n = 1
      20.times do |i|
         question = @questions.find_by(question_number: n)
         condition = post.conditions.find_by(category: question.category)
         patch condition_path(condition, question_number: n, point: 3)
         n += 1
      end
      20.times do |j|
         question = @questions.find_by(question_number: n)
         condition = post.conditions.find_by(category: question.category)
         patch condition_path(condition, question_number: n, point: 3)
         n += 1
      end

      assert_redirected_to condition_path(@another_employee)
      follow_redirect!
      assert_select '#condition-notice', 0
      assert_select '.post-reaction'

      assert_no_difference 'Post.count' do
         post new_condition_path
      end
      assert flash[:danger]
      assert_redirected_to condition_path(@another_employee)
   end

   test "interrupt in the checking questions" do
      check_term = Date.new(Date.today.year, Date.today.month, 15)
      Timecop.travel(check_term)
      login_as(@employee)
      get condition_path(@employee)

      post new_condition_path
      post = @employee.posts.where(post_type: "condition").order(:created_at).last
      condition = post.conditions.find_by(category: 1)
      assert_redirected_to edit_condition_url(condition, question_number: 1)

      assert_difference 'Post.count', -1 do
         get condition_path(@employee)
      end

      assert_select '#condition-notice'
      post new_condition_path
      post = @employee.posts.where(post_type: "condition").order(:created_at).last
      condition = post.conditions.find_by(category: 1)
      assert_redirected_to edit_condition_url(condition, question_number: 1)

   end
end
