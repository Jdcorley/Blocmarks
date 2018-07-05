class UsersController < ApplicationController
  def show
    
    @user_likes = current_user.likes 
    @user_bookmarks = current_user.bookmarks 
    @liked_bookmarks = @user_likes.each.map do |like|
                          like.bookmark 
    end 
  end
end
