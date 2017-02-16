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
Reaction.delete_all

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

User.where(employee: true).each do |user|
   Reaction.create!(
                  user_id: user.id,
                  post_id: Post.last.id
                   )
end

Question.create!( content: "仕事が面白いと感じる",
                  category: 1,
                  question_number: 1 )
Question.create!( content: "やる気に満ちている",
                  category: 1,
                  question_number: 2 )
Question.create!( content: "意欲的に取り組んでいる",
                  category: 1,
                  question_number: 3 )
Question.create!( content: "現状に満足せず、より高い目標に挑戦している",
                  category: 2,
                  question_number: 4 )
Question.create!( content: "期待以上の成果を出そうとしている",
                  category: 2,
                  question_number: 5 )
Question.create!( content: "問題意識をもって仕事の改善に取り組んでいる",
                  category: 2,
                  question_number: 6 )
Question.create!( content: "仕事を通して成長している実感がある",
                  category: 3,
                  question_number: 7 )
Question.create!( content: "同期や職場の人たちから刺激を受けている",
                  category: 3,
                  question_number: 8 )
Question.create!( content: "仕事にやりがいを感じている",
                  category: 3,
                  question_number: 9 )
Question.create!( content: "仕事の質を高める努力を継続している",
                  category: 4,
                  question_number: 10 )
Question.create!( content: "仕事関連のインプットに積極的だ",
                  category: 4,
                  question_number: 11 )
Question.create!( content: "スキル・能力の向上に努めている",
                  category: 4,
                  question_number: 12 )
Question.create!( content: "この会社で仕事の経験を積むことで、成長していけると思う",
                  category: 5,
                  question_number: 13 )
Question.create!( content: "この会社には、成長のための機会や支援が充実している",
                  category: 4,
                  question_number: 14 )
Question.create!( content: "今後自分がどうなっていきたいかについて、イメージがわく",
                  category: 5,
                  question_number: 15 )
Question.create!( content: "仕事の中で、今後自分の強みや得意なことを発揮していけると思う",
                  category: 5,
                  question_number: 16 )
Question.create!( content: "現在の仕事を通して、専門知識やスキルを身につけていけると思う",
                  category: 5,
                  question_number: 17 )
Question.create!( content: "仕事とプライベートのバランスがとれている",
                  category: 6,
                  question_number: 18 )
Question.create!( content: "仕事量が適切で、、想定通りに終わらせる事ができる",
                  category: 6,
                  question_number: 19 )
Question.create!( content: "納期や締め切りに追われないで仕事ができる",
                  category: 6,
                  question_number: 20 )
Question.create!( content: "残業や休日出勤が少ない",
                  category: 6,
                  question_number: 21 )
Question.create!( content: "プレッシャーを感じず、自分のペースで仕事ができる",
                  category: 7,
                  question_number: 22 )
Question.create!( content: "現在の仕事は、自分の知識や経験でまかなえるものだ",
                  category: 10,
                  question_number: 23 )
Question.create!( content: "今の仕事に対して適度な責任感を持って臨む事ができる",
                  category: 7,
                  question_number: 24 )
Question.create!( content: "仕事の進め方をある程度自分で定められる",
                  category: 2,
                  question_number: 25 )
Question.create!( content: "担当している仕事の難易度はあなたにとって適切だ",
                  category: 7,
                  question_number: 26 )
Question.create!( content: "自分の努力や仕事に対する姿勢は、周囲に認められていると思う",
                  category: 3,
                  question_number: 27 )
Question.create!( content: "職場の人間関係は良好だ",
                  category: 9,
                  question_number: 28 )
Question.create!( content: "先輩や同僚は、仕事で困ったときにはいつでもアドバイスや手助けをしてくれる",
                  category: 8,
                  question_number: 29 )
Question.create!( content: "職場の人たちと、ストレスなくコミュニケーションがとれている",
                  category: 9,
                  question_number: 30 )
Question.create!( content: "上司に対して仕事の報告・連絡・相談を滞りなくおこなっている",
                  category: 10,
                  question_number: 31 )
Question.create!( content: "上司は、やるべき仕事の範囲や量を適切にコントロールしてくれる",
                  category: 8,
                  question_number: 32 )
Question.create!( content: "上司は、あなたが責任を果たす上で必要なサポートを提供してくれる",
                  category: 8,
                  question_number: 33 )
Question.create!( content: "悩みや不安をため込むことなく主張できる",
                  category: 10,
                  question_number: 34 )
Question.create!( content: "休暇の取得や福利厚生に不満なく働くことができている",
                  category: 9,
                  question_number: 35 )
Question.create!( content: "効率的に仕事を進めるための設備・機器や仕組みが整っている職場の人たちと、ストレスなくコミュニケーションがとれている",
                  category: 8,
                  question_number: 36 )
Question.create!( content: "職場は清潔で快適である",
                  category: 9,
                  question_number: 37 )
Question.create!( content: "知りたいことがあるとき、誰に聞けばいいか明確にわかっている",
                  category: 10,
                  question_number: 38 )
Question.create!( content: "自分らしく仕事に取り組めていると思う",
                  category: 1,
                  question_number: 39 )
Question.create!( content: "今の仕事は、自分にあっていると感じている",
                  category: 7,
                  question_number: 40 )
