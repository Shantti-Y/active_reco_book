
Reaction.seed do |s|
   s.id      = 1
   s.user_id = User.find(2).id
   s.post_id = Post.where(user_id: User.find(1).id).last.id
end
