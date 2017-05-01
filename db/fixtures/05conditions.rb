
i = 1
Post.where(post_type: "condition").each do |post|
   10.times do |n|
      Condition.seed do |s|
         s.id      = i
         s.user_id = post.user.id
         s.post_id = post.id
         category  = n + 1
         point     = 0
      end
      i += 1
   end
end
