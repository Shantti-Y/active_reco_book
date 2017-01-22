class AccountManagementsController < ApplicationController

   def account_activation
      user = User.find_by(email: params[:email])
      if user && user.authenticated?('activate', params[:id]) && !user.activated?
         user.update_attribute(:activated, true)
         flash['info'] = "ようこそ、ActiveRecoBookへ！"
         login(user)
         redirect_to home_url
      else
         if user.nil? || !user.authenticated?('activate', params[:id])
            flash['danger'] = "正式に認証されませんでした。もう一度ご案内メールを確認してください。"
         elsif user.activated?
            flash['danger'] = "既に登録されているアカウントです。"
         end
         redirect_to login_url
      end
   end
end
