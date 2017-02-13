class StaticPagesController < ApplicationController
   before_action :is_logged_in?, only: [:home]

  def home
     @user = current_user
     @posts = Post.page(params[:page]).where(published: true).order(:created_at).reverse_order
  end

  def help
  end

  def about
  end

  def convention
  end
end
