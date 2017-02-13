class Comment < ApplicationRecord
   belongs_to :user
   belongs_to :post

   validates :user_id, presence: true
   validates :post_id, presence: true
   validates :content, presence: true,
                       length: { maximum: 1000 }

   validate :draft_post?

   private
      def draft_post?
         if !self.post.published?
            errors.add(:post_id, 'cannot comment to the drraft post')
         end
      end
end
