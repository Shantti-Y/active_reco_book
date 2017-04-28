class ConditionsController < ApplicationController
   before_action :is_logged_in?
   before_action :interrupted?, only: [:show]
   before_action :url_log

   def index
      @user = User.find(params[:id])
      @posts = @user.posts.where(post_type: "condition").where(published: true)
                    .order(:created_at).offset(2)
      respond_to do |format|
         format.html {}
         format.js {}
      end
   end

   def show
      @user = User.find(params[:id])
      @posts = @user.posts.where(post_type: "condition").where(published: true)
                    .order(:created_at).reverse_order.limit(2)
               @current_post = @posts.first
               @previous_post = @posts.last
      respond_to do |format|
         format.html {}
         format.js {}
      end
   end

   def edit
      @user = current_user
      @condition = Condition.find(params[:id])
      @question = Question.find_by(question_number: params[:question_number])
   end

   def create
      @post = current_user.posts.build(post_template("condition"))
      respond_to do |format|
         if time_to_answer?(current_user) == true
            @post.save
            10.times do |n|
               condition = current_user.conditions.build({post_id: @post.id, category: n + 1, point: 0})
               condition.save
            end
            @question = Question.find_by(question_number: 1)
            @condition = @post.conditions.find_by(category: @question.category)
            format.html { redirect_to edit_condition_url(@condition, question_number: 1) }
         else
            case time_to_answer?(current_user)
            when 1
               flash[:danger] = "次回の回答期間までこころチェック回答を制限しております。"
            when 0
               flash[:danger] = "回答期間外のこころチェック回答は受け付けておりません。"
            else
               flash[:danger] = "こころチェックの回答が制限されております"
            end
            format.html { redirect_to condition_url(current_user) }
         end
      end
   end

   def update
      @post = current_user.posts.where(post_type: "condition").last
      @condition = Condition.find(params[:id])
      @question_count = question_max?(params[:question_number])
      respond_to do |format|
         if @condition.update_attribute(:point, @condition.point + params[:point].to_i)
            if @question_count.nil?
               @post.update_attribute(:published, true)
               format.html { redirect_to condition_url(current_user) }
               format.js { render 'conditions/update' }
            else
               @question = Question.find_by(question_number: @question_count)
               @condition = @post.conditions.find_by(category: @question.category)
               format.html { redirect_to edit_condition_url(@condition, question_number: @question_count) }
               format.js { render 'conditions/update' }
            end
         end
      end
   end

   private
      def interrupted?
         unanswered_condition = current_user.posts.where(post_type: "condition").find_by(published: false)
          if unanswered_condition
             unanswered_condition.destroy
          end
      end
end
