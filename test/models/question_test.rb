require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

   def setup
      @question = Question.new(
                              content: "Are you a user?",
                              category: 1,
                              question_number: 41
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

   test "question number should be present" do
      @question.question_number = ""
      assert_not @question.valid?
   end

   test "question number should be unique" do
      @question.save
      @duplicated_question = Question.new(
                              content: "Are you a user?",
                              category: 1,
                              question_number: 1
                              )
      assert_not @duplicated_question.valid?
   end
end
