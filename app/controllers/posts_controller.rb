class PostsController < ApplicationController
   before_action :is_logged_in?

  def new
     @user = current_user
     @post = Post.new
  end

  def show
     @user = current_user
     @post = Post.find(params[:id])
  end

  def edit
     @user = current_user
     @post = Post.find(params[:id])
  end

  def create
     @user = current_user
     @post = current_user.posts.build(post_params)
     if @post.save
        flash[:success] = "新しい記録を投稿しました。"
        redirect_to home_url
     else
        render 'posts/new'
     end
  end

  def update
     @user = current_user
     @post = Post.find(params[:id])
      if @post.update_attributes(post_params)
          flash[:success] = "新しい記録を投稿しました。"
          redirect_to home_url
      else
          render 'posts/new'
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
