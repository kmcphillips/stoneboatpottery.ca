class Admin::WholesalePasswordsController < ApplicationController
  before_filter :require_login
  
  def index
    @wholesale_passwords = WholesalePassword.all(:order => "created_at DESC")
    @title = "Wholesale Passwords"
  end
  
  # def update
  #   @wholesale_password = WholesalePassword.find(params[:id])
  #   
  #   if @wholesale_password.update_attributes(params[:wholesale_password])
  #     flash[:notice] = "Wholesale password successfully updated."
  #     redirect_to admin_wholesale_passwords_path
  #   else
  #     flash[:error] = @wholesale_password.errors.full_messages.to_sentence
  #     render 'admin/functional_pieces/edit'
  #   end      
  # end

  def create
    @wholesale_password = WholesalePassword.new(params[:wholesale_password])
    
    if @wholesale_password.save
      flash[:notice] = "Wholesale password successfully created."
      redirect_to admin_wholesale_passwords_path
    else
      flash[:error] = @wholesale_password.errors.full_messages.to_sentence
      render 'admin/functional_pieces/new'
    end  
  end

  def destroy
    @wholesale_password = WholesalePassword.find_by_permalink(params[:id])

    if @wholesale_password.delete
      flash[:notice] = "Wholesale password successfully deleted."
    else
      flash[:error] = @wholesale_password.errors.full_messages.to_sentence
    end

    redirect_to admin_wholesale_passwords_path
  end

  
  def lineage
    [:admin, WholesalePassword.find(params[:id]) || WholesalePassword.new]
  end
  
end
