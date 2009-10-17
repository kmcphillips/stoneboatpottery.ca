class Admin::UsersController < ApplicationController
  before_filter :require_login
  
  def edit
    @user = User.find(params[:id])
    render 'admin/users/edit'
  end
  
  def update
    @user = User.find(params[:id])
    
    if params[:password] && params[:password_confirm]
      if params[:password] == params[:password_confirm]
        if @user.update_attributes(:password_hash => User.encrypt(params[:password]))
          flash[:notice] = "Password successfully changed."
        else
          flash[:error] = @user.errors.full_messages.to_sentence
        end      
      else
        flash[:error] = "Passwords do not match."
      end
    else
      flash[:error] = "Password was not passed for update."
    end

    redirect_to edit_admin_user_path(@user)
  end
  
end
