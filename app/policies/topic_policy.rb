class TopicPolicy < ApplicationPolicy
  
  def new?
    @user && !banned?
  end
  
  def create?
    @user && !banned?
  end
  
  def edit?
    admin? || (@user && (@record.user_id == @user.id))
  end
  
  def update?
    edit?
  end
  
  def destroy?
    edit?
  end
  
end