class Post < ApplicationRecord
   belongs_to :user

   validates :user_id, presence: true
   validates :content, presence: true,
                       length: { maximum: 1000 }
   validates :condition, format: { with: /blank|comfort|safe|caution|danger/ }
   validates :post_type, format: { with: /daily|condition|learning/ }

   
end
