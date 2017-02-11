module PostsHelper

   def post_class(post)
      case post.post_type
      when "daily"
         case post.condition
         when "blank"
            return "blank"
         when "comfort"
            return "comfort"
         when "safe"
            return "safe"
         when "caution"
            return "caution"
         when "danger"
            return "danger"
         end
      when "condition"
         return "condition"
      when "learning"
         return "learning"
      else
      end
   end

   def post_category(post)
      case post.post_type
      when "daily"
         return "投稿"
      when "condition"
         return "診断"
      when "learning"
         return "学習"
      else
      end
   end

   def post_icon(post)
      case post.post_type
      when "daily"
         case post.condition
         when "blank"
            return "blank.png"
         when "comfort"
            return "comfort.png"
         when "safe"
            return "safe.png"
         when "caution"
            return "caution.png"
         when "danger"
            return "danger.png"
         end
      when "condition"
         return "condition.png"
      when "learning"
         return "learning.png"
      else
      end
   end

   def post_condition(post)
      case post.condition
      when "blank"
         return ""
      when "comfort"
         return "余力あり"
      when "safe"
         return "ちょうど"
      when "caution"
         return "溜め気味"
      when "danger"
         return "手一杯"
      end
   end

end
