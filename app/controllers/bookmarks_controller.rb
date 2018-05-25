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
    @bookmark = @topic.bookmarks.build(bookmark_params)

    if @bookmark.save 
      flash[:notice] = 'Bookmark was saved.'
      redirect_to topics_path 
    else 
      flash.now[:alert] = 'There was an error saving the bookmark. The url may be invalid. Please copy and paste the full url you are trying to add.'
      render :new 
    end 
  end 

  def edit 
    @bookmark = Bookmark.find(params[:id])
  end 

  def destroy 
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy 
      flash[:notice] = 'Bookmark deleted successfully.'
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
