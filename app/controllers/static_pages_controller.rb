class StaticPagesController < ApplicationController

  def home
     @user = current_user
  end

  def help
  end

  def about
  end

  def convention
  end
end
