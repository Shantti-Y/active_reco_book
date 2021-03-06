class AccountManagementsController < ApplicationController

   def account_activation
      user = User.find_by(email: params[:email])
      if user && user.authenticated?('activate', params[:id]) && !user.activated?
         user.update_attribute(:activated, true)
         2.times do |m|
               post = user.posts.build(post_template("condition"))
               post.created_at = 1.year.ago
               post.save
            10.times do |n|
               condition = user.conditions.build({post_id: post.id, category: n + 1, point: 0})
               condition.save
            end
         end
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

   def password_reset_new

   end

   def password_reset_create
      user = User.find_by(email: params[:password_reset][:email])
      if user && user.employee_number == params[:password_reset][:employee_number].to_i
         user.update_attribute(:password_reset, true)
         user.update_attribute(:password_reset_sent_at, Time.now)
         user.send_password_reset_mail
         flash['success'] = "パスワード再発行のメールを送信しました。
         届いたメール内に記載されたパスワードで再ログインしてください。"
         redirect_to home_url
      else
         if user.nil? || user.employee_number != params[:password_reset][:employee_number].to_i
            flash['danger'] = "入力情報に不備があります"
         end
         render 'account_managements/password_reset_new'
      end
   end
end
