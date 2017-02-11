class CommentsController < ApplicationController

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
   end

   def create
      @user = current_user
      @comment = current_user.comments.build(comment_params)
      @post = Post.find(comment_params[:post_id])
      if @comment.save
         flash[:success] = "新しいコメントを投稿しました"
         redirect_to home_url
      else
         flash[:danger] = "入力情報に不備があります"
         render 'comments/new'
      end
   end

   def update
      @user = current_user
      @comment = Comment.find(params[:id])
      @post = @comment.post
      if @comment.update_attributes(comment_params)
         flash[:success] = "コメントを編集しました"
         redirect_to home_url
      else
         flash[:danger] = "入力情報に不備があります"
         render 'comments/edit'
      end
   end

   def destroy
      @user = current_user
      @comment = Comment.find(params[:id])
      if @comment.destroy
         flash[:info] = "コメントを削除しました"
         redirect_to home_url
      else
         flash[:danger] = "入力情報に不備があります"
         redirect_to home_url
      end
   end

   private
      def comment_params
         params.require(:comment).permit(:post_id, :content)
      end
end
