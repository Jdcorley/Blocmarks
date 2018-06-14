class BookmarksController < ApplicationController
  
  def show
    @bookmark = Bookmark.find(params[:id]) 
  end 

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new 
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params) 

    if @bookmark.save 
      flash[:notice] = 'Bookmark was saved.'
      redirect_to @topic 
    else 
      Rails.logger.info @bookmark.errors.full_messages
      flash.now[:alert] = 'There was an error saving this bookmark. Please check that the url you entered is valid.'
      render :new 
    end 
  end 

  def edit
    @bookmark = Bookmark.find(params[:id])
  end 

  def update 
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)

    if @bookmark.save 
      flash[:notice] = 'Bookmark was updated.'
      redirect_to @bookmark.topic
    else 
      flash.now[:alert] = 'There was an error updating this bookmark. Please check that the url you entered is valid.'
      render :edit  
    end 
  end 

  def destroy 
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy 
      flash[:notice] = 'Bookmark deleted successfully.'
      redirect_to @topic 
    else 
      flash.now[:alert] = 'There was an error deleted this bookmark.'
      render :show 
    end 
  end 

  private 

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end  

end
