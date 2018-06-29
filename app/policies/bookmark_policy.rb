class BookmarkPolicy < ApplicationPolicy
  def edit?
    user.id == record.user_id
  end 

  def update?
    edit?
  end 

  def destroy?
    edit?
  end 
end 