class Post < ApplicationRecord
   belongs_to :user
   has_many :comments, dependent: :destroy
   has_many :reactions, dependent: :destroy
   has_many :conditions, dependent: :destroy

   paginates_per 10

   validates :user_id, presence: true
   validates :content, presence: true,
                       length: { maximum: 1000 }
   validates :condition, format: { with: /blank|success|info|warning|danger/ }
   validate :not_daily?
   validates :post_type, format: { with: /daily|condition|learning/ }
   validates :published, inclusion: { in: [true, false] }

   private
      def not_daily?
         if self.post_type == "condition" || self.post_type == "learning"
             errors.add(:condition, 'is not about the daily') if self.condition != "blank"
         end
      end
end
