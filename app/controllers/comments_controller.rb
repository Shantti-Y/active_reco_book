class CommentsController < ApplicationController
   before_action :is_logged_in?
   before_action :url_log

   def new
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
      @comment = Comment.find(params[:id])
      @post = @comment.post
      @comments = @post.comments
      respond_to do |format|
         format.js {}
      end
   end

   def create
      @user = current_user
      @post = Post.find(comment_params[:post_id])
      @comment = current_user.comments.build(comment_params)
      respond_to do |format|
         if @comment.save
            flash[:success] = "新しいコメントを投稿しました。"
            format.html { redirect_back_to(root_url) }
            format.js { render 'comments/create' }
         else
            format.html { redirect_back_to(root_url) }
            format.js { render 'comments/create' }
         end
      end
   end

   def update
      @user = current_user
      @comment = Comment.find(params[:id])
      @post = @comment.post
      respond_to do |format|
         if @comment.update_attributes(comment_params)
            flash[:success] = "コメントを再投稿しました。"
            format.html { redirect_back_to(root_url) }
            format.js { render 'comments/update' }
         else
            format.html { redirect_back_to(root_url) }
            format.js { render 'comments/update' }
         end
      end
   end

   def destroy
      @user = current_user
      @comment = Comment.find(params[:id])
      if @comment.destroy
         flash[:info] = "コメントを削除しました"
         redirect_back_to(root_url)
      else
         flash[:danger] = "入力情報に不備があります"
         redirect_back_to(root_url)
      end
   end

   private
      def comment_params
         params.require(:comment).permit(:post_id, :content)
      end
end
