class IncomingController < ApplicationController
  require 'securerandom'
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
    puts "INCOMING PARAMS HERE: #{params}"

    user_from_email    = params[:sender]
    topic_from_email   = params[:subject]
    bookmark_from_email = params['stripped-text']
    puts user_from_email, topic_from_email, bookmark_from_email 

    if user_nil?(user_from_email)
      user_from_email = User.create!(email: user_from_email, 
                                     password: SecureRandom.hex,
                                     confirmed_at: Time.now)
      user_from_email.send_reset_password_instructions
    end

    this_user = User.find_by_email(user_from_email)
    puts this_user

    if topic_nil?(this_user, topic_from_email)
      topic_from_email = this_user.Topic.create!(title: topic_from_email)
    end 

    this_topic = Topic.find_by(title: topic_from_email)
    puts this_topic
    puts topic_from_email

    create_a_bookmark(this_user, this_topic, bookmark_from_email)
    
    head 200
    puts Bookmark.last 
  end

  def user_nil?(user_from_email)
    User.find_by(email: user_from_email).nil?
  end 

  def topic_nil?(this_user, topic_from_email)
    Topic.find_by(title: topic_from_email).nil?
  end 

  def create_a_bookmark(this_user, this_topic, bookmark_from_email)
    this_topic.Bookmark.create!(url: bookmark_from_email, user: this_user )
  end 
end
