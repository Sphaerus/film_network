class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(current_user.admin? ? users_params_for_admins : users_params_for_users)
        format.html { redirect_to edit_user_path(@user), notice: "User updated"}
      else
        format.html { render action: "edit"}
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_path, notice: "User successfully deleted"}
    end
  end
  
  private
  
  def users_params_for_users
    params.require(:user).permit(:nickname, :avatar)
  end
  
  def users_params_for_admins
    params.require(:user).permit(:nickname, :avatar, :admin, :banned)
  end
end