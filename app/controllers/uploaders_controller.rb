class UploadersController < ApplicationController

   def user_thumbnail
     @user = User.find(params[:id])
     send_data @user.thumbnail, type: @user.thumbnail_ctype, disposition: :inline
   end
   
end
