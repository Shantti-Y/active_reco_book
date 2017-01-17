class UsersController < ApplicationController
  def index
     @users = User.all
  end

  def show
     @user = User.find(params[:id])
  end

  def new
     @user = User.new
  end

  def edit
     @user = User.find(params[:id])
  end

  def create
     @user = User.new(user_params)
     if @user.save
        flash['success'] = "ユーザーの作成に成功しました。"
        redirect_to home_url
     else
        flash['danger'] = "入力情報に不備があります"
        render 'users/new'
     end
  end

  def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash['success'] = "ユーザー情報を更新しました"
         redirect_to home_url
      else
         flash['danger'] = "入力情報に不備があります"
         render 'users/edit'
      end
  end

  def destroy
     @user = User.find(params[:id])
     if @user.destroy
         redirect_to home_url
     else
        redirect_to home_url
     end
  end

  private
   def user_params
      params.require(:user).permit(:name, :email, :employee_number, :division, :gender, :started_at, :birthday, :employee)
   end
end
