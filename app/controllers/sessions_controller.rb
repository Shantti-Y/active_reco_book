class SessionsController < ApplicationController
   before_action :is_logged_in?, only: [:destroy]

  def new
     if is_logged?
        user = current_user
        logout
        forget(user)
     end
  end

  def create
     user = User.find_by(email: params[:session][:email])
     if user && user.authenticate(params[:session][:password]) && user.activated? && !user.password_expired?
        params[:session][:remembered] == "1" ? remember(user) : forget(user)
        flash[:info] = "ようこそ、Active Reco Bookへ！"
        login(user)
        redirect_to home_url
     else
        if user.password_expired?
           flash[:danger] = "パスワードの有効期限が切れています"
        else
           flash[:danger] = "入力情報に不備があるか、アカウントが登録されていません"
        end
        render 'sessions/new'
     end
  end

  def destroy
     user = User.find(params[:id])
     if user
        logout
        forget(user)
        redirect_to login_url
     end
  end
end
