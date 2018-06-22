class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
     # Take a look at these in your server logs
     # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"

    user_from_email    = params[:sender]
    topic_from_email   = params[:subject]
    bookmark_from_email = params['body-plain']
    # body_without_quotes = request.POST.get('stripped-text', '')
    # recipient = request.POST.get('recipient')
    if user_nil(user_from_email)
      user_from_email = User.create!(email: user_from_email)
    end

    if topic_nil(topic_from_email)
      topic_from_email = Topic.create!(title: topic_from_email)
    end 

    create_a_bookmark(user_from_email, topic_from_email, bookmark_from_email)
    
    head 200
  end

  def user_nil(user_from_email)
    User.find_by(email: user_from_email).nil?
  end 

  def topic_nil(topic_from_email)
    Topic.find_by(title: topic_from_email).nil?
  end 

  def create_a_bookmark(user_from_email, topic_from_email, bookmark_from_email)
    User.find_by(email: user_from_email).topics.find_by(title: topic_from_email).bookmarks.create!(url: bookmark_from_email)
  end 
end
