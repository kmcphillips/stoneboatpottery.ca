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
      if params[:password] && params[:password_confirm]
        if params[:password] == params[:password_confirm]
          if params[:password].length >= 4
            if @user.update_attributes(:password_hash => User.encrypt(params[:password]))
              flash[:notice] = "Password successfully changed."
            else
              flash[:error] = @user.errors.full_messages.to_sentence
            end
          else
            flash[:error] = "Password must be at least four characters."
          end
        else
          flash[:error] = "Passwords do not match."
        end
      else
        flash[:error] = "Password was not passed for update."
      end
    else
      flash[:error] = "You can only update your own password."
    end

    redirect_to edit_admin_user_path(@user)
  end
  
end
