class ReactionsController < ApplicationController
   before_action :is_logged_in?
   before_action :url_log

   def create
      @user = current_user
      @post = Post.find(params[:id])
      @reaction = current_user.reactions.build(post_id: @post.id)
      respond_to do |format|
         if @reaction.save
            format.html { redirect_back_to(root_url) }
            format.js { render 'reactions/create' }
         else
            flash[:danger] = "反応できませんでした"
            format.html { redirect_back_to(root_url) }
            format.js { render 'reactions/create' }
         end
      end
   end

   def destroy
      @user = current_user
      @post = Post.find(params[:id])
      @reaction = current_user.reactions.find_by(post_id: params[:id])
      respond_to do |format|
         if @reaction.destroy
            format.html { redirect_back_to(root_url) }
            format.js { render 'reactions/destroy' }
         else
            flash[:danger] = "反応できませんでした"
            format.html { redirect_back_to(root_url) }
            format.js { render 'reactions/destroy' }
         end
      end
   end

end
