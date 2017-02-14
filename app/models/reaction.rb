class Reaction < ApplicationRecord
   belongs_to :user
   belongs_to :post

   validates :user_id, presence: true
   validates :post_id, presence: true
   validate :unique?

   private
      def unique?
         if Reaction.where(user_id: self.user_id).find_by(post_id: self.post_id)
            errors.add(:post_id, 'can not react to the same post')
         end
      end
end
