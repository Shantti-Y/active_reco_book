
Comment.seed do |s|
   s.id      = 1
   s.user_id = User.find(3).id
   s.post_id = Post.find(1).id
   s.content = "調子はどうですか？何かあったら気兼ねなくここに投稿してください。"
end
