class LikesController < ApplicationController
  
  def index
  end 

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      flash[:notice] = 'Bookmark liked!' 
      redirect_to @bookmark
    else 
      flash.now[:alert] = 'There was an issue liking this bookmark.'
      redirect_to @bookmark

    end 
  end

  def destroy
    @topic = Topic.find_by(params[:id])
    @bookmark = Bookmark.find(params[:id])
    @like = @bookmark.likes.find_by(params[:id])


    if @like.destroy 
      flash[:notice] = 'Bookmark un-liked!' 
      redirect_to @bookmark
    else 
      flash.now[:alert] = "There was an issue un-liking this bookmark. 
      Looks like you'll just have to like it forever."
      redirect_to @bookmark
    end 
  end
end
