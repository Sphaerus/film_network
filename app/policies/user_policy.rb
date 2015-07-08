class UserPolicy < ApplicationPolicy
  
  def index?
    !@user.nil?
  end
  
  def show?
    !@user.nil?
  end
  
  def edit?
    admin? || @record.id == @user.id
  end
  
  def destroy?
    admin?
  end
  
  def update?
    edit?
  end
  
  def admin?
    @user && @user.admin
  end
end