class PostsController < ApplicationController
   before_action :is_logged_in?

  def new
     @user = current_user
     @post = Post.new
  end

  def show
  end

  def edit
  end

  def create

  end

  def update

  end

  def destroy

  end
end
