class SessionsController < ApplicationController
   
  def new
  end

  def create
     user = User.find_by(email: params[:session][:email])
     if user && user.authenticate(params[:session][:password])
        flash[:info] = "ようこそ、ActiveRecoBookへ！"
        login(user)
        redirect_to home_url
     else
        flash[:danger] = "入力情報に不備があるか、アカウントが登録されていません"
        render 'sessions/new'
     end
  end

  def destroy
     logout
     redirect_to login_url
  end
end
