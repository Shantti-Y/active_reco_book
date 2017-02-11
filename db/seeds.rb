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
            condition: "safe",
            post_type: "daily"
            )

User.where(employee: true).each do |user|
  10.times do |n|
    Post.create!( user_id: user.id,
                  content: Faker::Lorem.sentence(40),
                  condition: 'comfort',
                  post_type: 'daily'
                  )
  end
end

Comment.create!(
               user_id: User.find_by(name: "例得 升男").id,
               post_id: Post.last.id,
               content: "Active Reco Bookへようこそ",
               )
