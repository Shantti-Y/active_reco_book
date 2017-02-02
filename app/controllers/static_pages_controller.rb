class StaticPagesController < ApplicationController
   before_action :is_logged_in?, only: [:home]

  def home
     @user = current_user
     @posts = Post.all
  end

  def help
  end

  def about
  end

  def convention
  end
end
