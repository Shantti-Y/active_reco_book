class StaticPagesController < ApplicationController
   before_action :is_logged_in?, only: [:home]

  def home
     @user = current_user
     @posts = Post.order(:created_at).reverse_order
     @comments = Comment.all
     @comment = Comment.new
  end

  def help
  end

  def about
  end

  def convention
  end
end
