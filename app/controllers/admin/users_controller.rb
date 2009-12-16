class Admin::UsersController < ApplicationController
  before_filter :require_login
  
  def edit
    @user = User.find(params[:id])
    @title = "Change Password"
    render 'admin/users/edit'
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user == current_user
      if @user.change_password(params[:password], params[:password_confirm])
        flash[:notice] = "Password successfully changed."
      else
        flash[:error] = @user.errors.full_messages.to_sentence
      end
    else
      flash[:error] = "You can only update your own password."
    end


    redirect_to edit_admin_user_path(@user)
  end
  
end
