class PostsController < ApplicationController
   before_action :is_logged_in?

  def new
     @user = current_user
     @post = Post.new
     respond_to do |format|
        format.js {}
     end
  end

  def show
     @user = current_user
     @post = Post.find(params[:id])
     @comments = @post.comments
     @comment = Comment.new
     respond_to do |format|
      format.js {}
     end
  end

  def edit
     @user = current_user
     @post = Post.find(params[:id])
     respond_to do |format|
       format.js {}
     end
  end

  def create
     @user = current_user
     @post = current_user.posts.build(post_params)
     respond_to do |format|
        if @post.save
           flash[:success] = "新しい記録を投稿しました。"
           format.html { redirect_to home_url }
           format.js { render 'posts/create' }
        else
           format.html { redirect_to home_url }
           format.js { render 'posts/create' }
        end
     end

  end

  def update
     @user = current_user
     @post = Post.find(params[:id])
      respond_to do |format|
         if @post.update_attributes(post_params)
            flash[:success] = "記録を再投稿しました。"
            format.html { redirect_to home_url }
            format.js { render 'posts/update' }
         else
            format.html { redirect_to home_url }
            format.js { render 'posts/update' }
         end
      end
  end

  def destroy
     @user = current_user
     @post = Post.find(params[:id])
     if @post.destroy
        flash[:info] = "記録を削除しました。"
        redirect_to home_url
     else
        flash[:danger] = "この投稿は削除できません"
        redirect_to home_url
     end
  end

  private
   def post_params
      params.require(:post).permit(:content, :condition, :post_type)
   end
end
