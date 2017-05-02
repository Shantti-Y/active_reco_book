module ConditionsHelper
   # Chart helpers
   def radar_params(current_post, previous_post)
      current_points = []
      current_conditions = current_post.conditions.order(:category)
      current_conditions.each do |condition|
         current_points << condition.point
      end

      previous_points = []
      previous_conditions = previous_post.conditions.order(:category)
      previous_conditions.each do |condition|
         previous_points << condition.point
      end
      return {
              labels: ["a.仕事の忙しさ", "b.プレッシャー",
                       "c.周囲の支え", "d.働く環境",
                       "e.職場への適応", "f.仕事への意欲",
                       "g.成果への挑戦", "h.成長実感",
                       "i.自己研鑽", "j.将来展望"],
              datasets: [
                {
                    label: "今回の結果",
                    background_color: 'rgba(241, 194, 192, 0.2)',
                    border_color: 'rgba(217, 83, 79, 0.6)',
                    border_width: 1,
                    point_background_color: 'rgba(217, 83, 79, 1)',
                    point_border_color: 'rgba(255, 255, 255, 1)',
                    point_hover_background_color: 'rgba(217, 83, 79, 1)',
                    point_hover_border_color: 'rgba(217, 83, 79, 1)',
                    data: current_points
                },
                {
                    label: "前回の結果",
                    background_color: 'rgba(192, 230, 242, 0.2)',
                    border_color: 'rgba(91, 192, 222, 0.6)',
                    border_width: 1,
                    point_background_color: 'rgba(91, 192, 222, 0.6)',
                    point_border_color: 'rgba(255, 255, 255, 1)',
                    point_hover_background_color: 'rgba(91, 192, 222, 1)',
                    point_hover_border_color: 'rgba(91, 192, 222, 1)',
                    data: previous_points
                }
              ]
            }
   end

   def radar_option
      return {
               tooltips: { enabled: false },
               scale: {
                  pointLabels: {
                        fontSize: 9,
                        fontFamily: "'メイリオ', 'Meiryo', 'ヒラギノ角ゴ Pro W3',
                        'Hiragino Kaku Gothic Pro', 'ＭＳ Ｐゴシック','MS PGothic'"
                      },
                  ticks: {
                     display: false,
                     min: 0,
                     max: 20,
                     stepSize: 5
               }
            }
         }
   end

   def line_params(posts)

      posts_date = Array.new(12, "")
      posts_burden = Array.new(12)
      posts_motivation = Array.new(12)
      n = 0

      posts.each do |post|
         posts_date[n] = [post.created_at.strftime("%Y年"), post.created_at.strftime("%m月%d日")]
         burdens = post.conditions.order(:category).limit(5)
         burden_point = 0
         burdens.each do |burden|
            burden_point += burden.point
         end
         posts_burden[n] = burden_point

         motivations = post.conditions.order(:category).reverse_order.limit(5)
         motivation_point = 0
         motivations.each do |motivation|
            motivation_point += motivation.point
         end
         posts_motivation[n] = motivation_point
         n += 1
      end

      result = {
         xLabels: posts_date,
         datasets: [
            {
               label: "負担感(注意・普通・良好)",
               fill: false,
               background_color: "rgba(255, 194, 179, 0.6)",
               border_color: "rgba(255, 71, 26, 0.6)",
               point_background_color: "rgba(255, 194, 179, 0.6)",
               data: posts_burden
            },
            {
               label: "モチベーション(低・中・高)",
               fill: false,
               background_color: "rgba(153, 214, 255, 0.6)",
               border_color: "rgba(51, 173, 255, 0.6)",
               point_background_color: "rgba(153, 214, 255, 0.6)",
               data: posts_motivation
            }
         ]
      }
   end

   def line_option
      return {
         width: 625,
         height: 260,
         tooltips: { enabled: false },
         responsive: false,
         maintainAspectRatio: false,
         onResize: false,
         span_gaps: false,
         scales: {
            xAxes: [{
               ticks: {
                  fontSize: 10,
                  beginAtZero: true
               },
               gridLines: { display: false }
            }],
            yAxes: [{
               ticks: {
                  display: false,
                  max: 100,
                  min: 20,
                  stepSize: 20
               },
            }]
         },
      }
   end

   # Recognize data from conditions

   def condition_summary(label, post)
      burdens = post.conditions.order(:category).limit(5)
      burden_point = 0
      burdens.each do |burden|
         burden_point += burden.point
      end
      burden_result = ""
      burden_class = ""
      if burden_point >= 20 && burden_point <= 36
         burden_result = "注意"
         burden_class = "danger"
      elsif burden_point >= 37 && burden_point <= 84
         burden_result = "ふつう"
         burden_class = "warning"
      elsif burden_point >= 85 && burden_point <= 100
         burden_result = "良好"
         burden_class = "info"
      else
         burden_result = "なし"
      end

      motivations = post.conditions.order(:category).reverse_order.limit(5)
      motivation_point = 0
      motivations.each do |motivation|
         motivation_point += motivation.point
      end
      motivation_result = ""
      motivation_class = ""
      if motivation_point >= 20 && motivation_point <= 44
         motivation_result = "低"
         motivation_class = "danger"
      elsif motivation_point >= 45 && motivation_point <= 76
         motivation_result = "中"
         motivation_class = "warning"
      elsif motivation_point >= 77 && motivation_point <= 100
         motivation_result = "高"
         motivation_class = "info"
      else
         motivation_result = "なし"
      end

      result = {}

      if label == "detail"
         result = {
                  burden: { class: burden_class, title: burden_result },
                  motivation: { class: motivation_class, title: motivation_result }
                  }
         return result
      end

      if burden_result == "注意" && motivation_result == "低"
         result = {
                  class: "exhausted",
                  title: "ヘトヘト",
                  image: "danger.png",
                  subtitle: "心身ともに限界の状態",
                  description: ""
                  }
      elsif burden_result == "注意" && (motivation_result == "中" || motivation_result == "低")
         result = {
                  class: "aggressive",
                  title: "ギリギリ",
                  image: "warning.png",
                  subtitle: "ギリギリな状態",
                  description: ""
                  }
      elsif (burden_result == "ふつう" || burden_result == "良好") && motivation_result == "低"
         result = {
                  class: "gloomy",
                  title: "モヤモヤ",
                  image: "warning.png",
                  subtitle: "モヤモヤな状態",
                  description: ""
                  }
      elsif (burden_result != "注意" && motivation_result != "低") &&
            (burden_result != "なし" && motivation_result != "なし")
         result = {
                  class: "vivacious",
                  title: "イキイキ",
                  image: "info.png",
                  subtitle: "仕事に打ち込めている状態",
                  description: ""
                  }
      else
         result = {
                  class: "nothing",
                  title: "未回答",
                  image: "blank.png",
                  subtitle: "こころチェックは行われておりません",
                  description: "質問に回答して自分のこころの状態を確認しましょう。"
                  }
      end

      case label
      when "class"
         return result[:class]
      when "title"
         return result[:title]
      when "image"
         return result[:image]
      when "subtitle"
         return result[:subtitle]
      when "description"
         return result[:description]
      else
      end
   end

   def condition_fa(label, position, post)
      if label == "burden"
         burdens = post.conditions.order(:category).limit(5)
         burden_point = 0
         burdens.each do |burden|
            burden_point += burden.point
         end
         if position == "danger" &&
            burden_point >= 20 && burden_point <= 36
            return 'check-square-o'
         elsif position == "warning" &&
            burden_point >= 37 && burden_point <= 84
            return 'check-square-o'
         elsif position == "info" &&
            burden_point  >= 85 && burden_point <= 100
            return 'check-square-o'
         else
            return 'square-o'
         end

      elsif label == "motivation"
         motivations = post.conditions.order(:category).reverse_order.limit(5)
         motivation_point = 0
         motivations.each do |motivation|
            motivation_point += motivation.point
         end
         if position == "danger" &&
            motivation_point >= 20 && motivation_point <= 44
            return 'check-square-o'
         elsif  position == "warning" &&
            motivation_point >= 45 && motivation_point <= 76
            return 'check-square-o'
         elsif position == "info" &&
            motivation_point >= 77 && motivation_point <= 100
            return 'check-square-o'
         else
            return 'square-o'
         end
      end
   end

   # Regulate to answer questionnaires if user does not meet conditions
   def time_to_answer?(user)
      term_current = Date.today
      term_start = Date.new(term_current.year, term_current.month, 15)
      term_end = Date.new(term_current.year, term_current.month, -1)

      if term_current >= term_start && term_current <= term_end
         user_latest_post = user.posts.where(post_type: "condition").order(:created_at).last

         if user_latest_post.created_at.month != term_current.month ||
            user_latest_post.created_at.year != term_current.year
            return true
         else
            if user.posts.where(post_type: "condition").count == 2
               return true
            else
               return 1
            end
         end
      else
         return 0
      end
   end
end
