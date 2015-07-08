class MoviePolicy < ApplicationPolicy
  
  def new?
    @user
  end
  
  def create?
    @user
  end
  
  def edit?
    admin? || (@user && (@record.user_id == @user.id || @record.opened?))
  end
  
  def update?
    edit?
  end
  
  def destroy
    edit?
  end
  
end