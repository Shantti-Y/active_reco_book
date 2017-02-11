module UploadersHelper
   def show_user_thumbnail(user)
     unless user.thumbnail.nil?
      return user_thumbnail_uploader_path(user)
     else
      return "default_avatar.png"
     end
   end
end
