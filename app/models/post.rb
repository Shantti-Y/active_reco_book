class Post < ApplicationRecord
   belongs_to :user
   has_many :comments, dependent: :destroy
   has_many :reactions, dependent: :destroy

   paginates_per 10

   validates :user_id, presence: true
   validates :content, presence: true,
                       length: { maximum: 1000 }
   validates :condition, format: { with: /blank|success|info|warning|danger/ }
   validates :post_type, format: { with: /daily|condition|learning/ }
   validates :published, inclusion: { in: [true, false] }


end
