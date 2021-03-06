class Condition < ApplicationRecord
   belongs_to :user
   belongs_to :post

   validates :user_id, presence: true
   validates :post_id, presence: true
   validates :category, presence: true
   validates :point, presence: true
end
