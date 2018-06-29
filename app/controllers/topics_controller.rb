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
    @topic = Topic.find(params[:id])
  end

  def update 
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)
    authorize @topic 

    if @topic.save 
      flash[:notice] = 'Topic was updated.'
      redirect_to @topic
    else 
      flash.now[:alert] = 'There was an error updating this topic. Please try again.'
      render :edit  
    end 
  end 

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic 
    if @topic.destroy 
      flash[:notice] = 'Topic deleted successfully.'
      redirect_to topics_path
    else 
      flash.now[:alert] = 'There was an error deleted this topic.'
      render :show 
    end  
  end 

  private 

  def topic_params 
    params.require(:topic).permit(:title)
  end 


end
