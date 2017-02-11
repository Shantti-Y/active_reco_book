class StaticPagesController < ApplicationController
   before_action :is_logged_in?, only: [:home]

  def home
     @user = current_user
     @posts = Post.page(params[:page]).order(:created_at).reverse_order
     respond_to do |format|
        format.html{}
        format.js{}
     end
  end

  def help
  end

  def about
  end

  def convention
  end
end
