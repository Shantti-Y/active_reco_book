module PostsHelper

   def post_class(post)
      case post.post_type
      when "daily"
         case post.condition
         when "success"
            return "success"
         when "info"
            return "info"
         when "warning"
            return "warning"
         when "danger"
            return "danger"
         else
            return "blank"
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
         when "success"
            return "success.png"
         when "info"
            return "info.png"
         when "warning"
            return "warning.png"
         when "danger"
            return "danger.png"
         else
            return ""
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
      when "success"
         return "余力あり"
      when "info"
         return "ちょうど"
      when "warning"
         return "溜め気味"
      when "danger"
         return "手一杯"
      else
         return ""
      end
   end

   def post_content(post)
      return post.content.slice(0, 140)
   end

end
