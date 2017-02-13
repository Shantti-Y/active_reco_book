# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Post.delete_all
Comment.delete_all

User.create!(
            name: "例得 升男",
            email: "example@mail.co.jp",
            employee_number: 12345678,
            division: "技術部開発課",
            gender: "男",
            started_at: Date.new(2015, 4, 1),
            birthday: Date.new(1992, 1, 1),
            employee: true,
            password_digest: User.digest('password'),
            activated: true,
            password_reset: false,
            password_reset_sent_at: Time.now
            )

User.create!(
            name: "例得 等",
            email: "another@mail.co.jp",
            employee_number: 23456789,
            division: "営業部企画課",
            gender: "男",
            started_at: Date.new(2015, 4, 1),
            birthday: Date.new(1992, 1, 1),
            employee: true,
            password_digest: User.digest('password'),
            activated: true,
            password_reset: false,
            password_reset_sent_at: Time.now
            )

Post.create!(
            user_id: User.find_by(name: "例得 升男").id,
            content: "Active Reco Bookへようこそ",
            condition: "info",
            post_type: "daily",
            published: false
            )

User.where(employee: true).each do |user|
  100.times do |n|
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
    Post.create!( user_id: user.id,
                  content: Faker::Lorem.sentence(40),
                  condition: condition,
                  post_type: 'daily',
                  published: true
                  )
  end
end

Comment.create!(
               user_id: User.find_by(name: "例得 升男").id,
               post_id: Post.last.id,
               content: "Active Reco Bookへようこそ",
               )
