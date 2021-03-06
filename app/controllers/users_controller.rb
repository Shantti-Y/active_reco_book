class UsersController < ApplicationController
   before_action :is_logged_in?
   before_action :url_log

  def index
     @users = User.all
  end

  def show
     @user = User.find(params[:id])
     @published = true
     if !params[:published].nil? || params[:published] == "0"
        @published = false
     end
     @posts = Post.page(params[:page]).where(user_id: @user.id).where(published: @published).order(:created_at).reverse_order
     respond_to do |format|
       format.html {}
       format.js {}
     end
  end

  def search_user
     @user = User.find(params[:id])
     @published = true
     @word = params[:post][:word]
     if !params[:post][:published].nil? || params[:post][:published] == "0"
       @published = false
     end
     @posts = Post.page(params[:page]).where(user_id: @user.id).where(published: @published).where("content LIKE ?", "%#{params[:post][:word]}%").order(:created_at).reverse_order
     respond_to do |format|
      format.js {}
     end
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
        @user.send_activation_mail
        @user.update_attribute(:password_reset_sent_at, Time.now)
        flash['success'] = "本登録のメールを送信しました。
        届いたメール内に記載されたURLをクリックして登録を完了してください"
        redirect_back_to(root_url)
     else
        flash['danger'] = "入力情報に不備があります"
        render 'users/new'
     end
  end

  def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash['success'] = "ユーザー情報を更新しました"
         redirect_back_to(root_url)
      else
         flash['danger'] = "入力情報に不備があります"
         render 'users/edit'
      end
  end

  def destroy
     @user = User.find(params[:id])
     if @user.destroy
         redirect_back_to(root_url)
     else
        redirect_back_to(root_url)
     end
  end

  def edit_password
     @user = User.find(params[:id])
  end

  def update_password
     @user = User.find(params[:id])
     if @user && @user.authenticate(params[:password][:current_password]) && params[:password][:new_password].length >= 8 &&
        params[:password][:new_password] == params[:password][:password_confirmation]
        if @user.update_attribute(:password_digest, User.digest(params[:password][:new_password]))
           @user.update_attribute(:password_reset, false)
           flash[:success] = "パスワードの変更を完了しました"
           redirect_back_to(root_url)
        else
           flash['danger'] = "新しいパスワードが有効ではありません"
           render 'users/edit_password'
        end
     else
        if !@user.authenticate(params[:password][:current_password])
           flash['danger'] = "現在のパスワードが正しく入力されていません"
        elsif params[:password][:new_password] != params[:password][:password_confirmation] || params[:password][:new_password].length < 8
           flash['danger'] = "新しいパスワードが正しく入力されていません"
        end
        render 'users/edit_password'
     end
  end

  private
   def user_params
      params.require(:user).permit(:name, :email, :employee_number, :division, :gender,
       :started_at, :birthday, :employee, :password, :password_confirmation, :uploaded_thumbnail)
   end
end
