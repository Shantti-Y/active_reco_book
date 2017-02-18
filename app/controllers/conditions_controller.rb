class ConditionsController < ApplicationController
   before_action :is_logged_in?

   def show
      @user = current_user
   end

   def edit

   end

   def create

   end

   def update

   end
end
