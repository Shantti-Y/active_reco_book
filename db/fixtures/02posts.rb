
Post.seed do |s|
   s.id        = 1
   s.user_id   = User.find(1).id
   s.content   = "Active Reco Bookへようこそ"
   s.condition = "info"
   s.post_type = "daily"
   s.published = true
end

Post.seed do |s|
   s.id        = 2
   s.user_id   = User.find(1).id
   s.content   = "下書きの最中ですよ"
   s.condition = "info"
   s.post_type = "daily"
   s.published = false
end

i = 3
10.times do |n|
   User.where(employee: true).each do |user|
      condition = String.new
      rand_value = Random.rand(4)
      case rand_value
      when 0 then
         condition = "success"
      when 1 then
         condition = "info"
      when 2 then
         condition = "warning"
      when 3 then
         condition = "danger"
      else
      end

      Post.seed do |s|
         s.id        = i
         s.user_id   = user.id
         s.content   = Faker::Lorem.sentence(40)
         s.condition = condition
         s.post_type = "daily"
         s.published = true
      end
      i += 1
   end
end

User.where(employee: true).each do |user|
   2.times do |n|
      Post.seed do |s|
         s.id        = i
         s.user_id   = user.id
         s.content   = "「心の状態」は周囲には見えにくく、一方で変わりやすいもの。タイミングよく適切なフォローが重要です。",
         s.condition = "blank"
         s.post_type = "condition"
         s.published = true
      end
      i += 1
   end
end
