require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

   def setup
      @question = Question.new(
                              content: "Are you a user?",
                              category: 1
                              )
   end

   test "should be valid" do
      assert @question.valid?
   end

   test "content should be present" do
      @question.content = ""
      assert_not @question.valid?
   end

   test "category should be present" do
      @question.category = ""
      assert_not @question.valid?
   end
end
