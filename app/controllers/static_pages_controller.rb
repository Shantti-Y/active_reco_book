class StaticPagesController < ApplicationController
   before_action :is_logged_in?, only: [:home]
   before_action :url_log, only: [:home]

  def home
      @user = current_user
      @posts = Post.page(params[:page]).where(published: true).order(:created_at).reverse_order
  end

  def search_home
     @user = current_user
     @posts = Post.page(params[:page]).where(published: true).where("content LIKE ?", "%#{params[:post][:word]}%").order(:created_at).reverse_order
     respond_to do |format|
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
