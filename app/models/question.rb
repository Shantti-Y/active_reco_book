class Question < ApplicationRecord

   validates :content, presence: true
   validates :category, presence: true
end
