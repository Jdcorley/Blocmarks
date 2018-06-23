class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
    puts "INCOMING PARAMS HERE: #{params}"

    user_from_email    = params[:sender]
    topic_from_email   = params[:subject]
    bookmark_from_email = params['stripped-text']
    puts user_from_email, topic_from_email, bookmark_from_email 

    if user_nil(user_from_email)
      user_from_email = User.create!(email: user_from_email)
    end

    current_user = user_from_email
    puts current_user

    if topic_nil(topic_from_email)
      topic_from_email = current_user.Topic.create!(title: topic_from_email)
    end 

    puts topic_from_email

    create_a_bookmark(topic_from_email, bookmark_from_email)
    
    head 200
    puts Bookmark.last 
  end

  def user_nil(user_from_email)
    User.find_by(email: user_from_email).nil?
  end 

  def topic_nil(topic_from_email)
    Topic.find_by(title: topic_from_email).nil?
  end 

  def create_a_bookmark( topic_from_email, bookmark_from_email)
    Topic.find_by(title: topic_from_email).bookmarks.create!(url: bookmark_from_email)
  end 
end
