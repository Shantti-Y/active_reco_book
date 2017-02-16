class Question < ApplicationRecord

   validates :content, presence: true
   validates :category, presence: true
   validates :question_number, presence: true,
                               uniqueness: true
end
