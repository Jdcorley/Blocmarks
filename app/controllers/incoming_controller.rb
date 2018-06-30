class IncomingController < ApplicationController
  require 'securerandom'
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
    user_from_email    = params[:sender]
    topic_from_email   = params[:subject]
    bookmark_from_email = params['stripped-text']

    if user_nil?(user_from_email)
      User.create!(email: user_from_email, 
                   password: SecureRandom.hex,
                   confirmed_at: Time.now).send_reset_password_instructions
    end
    current_user = User.find_by_email(user_from_email)

    if topic_nil?(topic_from_email)
      current_user.topics.create!(title: topic_from_email)
    end
    this_topic = Topic.find_by(title: topic_from_email)

    this_topic.bookmarks.create!(url: bookmark_from_email, user: current_user )
    
    head 200
  end

  def user_nil?(user_from_email)
    User.find_by(email: user_from_email).nil?
  end 

  def topic_nil?(topic_from_email)
    Topic.find_by(title: topic_from_email).nil?
  end 

end 
