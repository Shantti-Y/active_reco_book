module QuestionsHelper
   def question_max?(question_number)
      question_number = question_number.to_i
      if question_number == Question.count
         return nil
      else
         return (question_number + 1).to_i
      end
   end
end
