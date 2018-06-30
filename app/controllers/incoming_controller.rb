class IncomingController < ApplicationController
  require 'securerandom'
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
    # strip incoming email for the goods
    puts "INCOMING PARAMS HERE: #{params}"
    user_from_email    = params[:sender]
    topic_from_email   = params[:subject]
    bookmark_from_email = params['stripped-text']
    puts user_from_email, topic_from_email, bookmark_from_email
    # user_nil? if so create new user and send password reset
    if user_nil?(user_from_email)
      User.create!(email: user_from_email, 
                   password: SecureRandom.hex,
                   confirmed_at: Time.now)
    end
    # set current_user to user from the email
    current_user = User.find_by_email(user_from_email)
    puts current_user
    # topic_nil? if so create new topic with topic parsed from email
    if topic_nil?(topic_from_email)
      current_user.topics.create!(title: topic_from_email)
    end 
    # set the topic to this_topic 
    this_topic = Topic.find_by(title: topic_from_email)
    puts this_topic
    puts topic_from_email
    # create the bookmark with this_topic and the bookmark url from email
    create_a_bookmark(this_topic, bookmark_from_email)
    
    head 200
    puts Bookmark.last 
  end

  def user_nil?(user_from_email)
    User.find_by(email: user_from_email).nil?
  end 

  def topic_nil?(topic_from_email)
    Topic.find_by(title: topic_from_email).nil?
  end 

  def create_a_bookmark(this_topic, bookmark_from_email)
    this_topic.bookmarks.create!(url: bookmark_from_email, user: current_user )
  end 

  current_user.send_reset_password_instructions if current_user == User.last  
end
