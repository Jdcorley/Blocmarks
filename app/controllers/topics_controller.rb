class TopicsController < ApplicationController
  def index
    @topics = Topic.all 
  end

  def new
    @topic = Topic.new 
  end 

  def create 
    @topic = Topic.new(topic_params) 
    @topic.user = current_user 

    if @topic.save 
      flash[:notice] = 'Topic was saved.'
      redirect_to topics_path
    else 
      flash.now[:alert] = 'There was an error saving the topic. Please try again.'
      render :new 
    end 
  end 

  def show
    @topic = Topic.find(params[:id])
  end

  def edit
  end

  def destroy 
  end 

  private 

  def topic_params 
    params.require(:topic).permit(:title)
  end 


end
