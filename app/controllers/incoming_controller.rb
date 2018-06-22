class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
     # Take a look at these in your server logs
     # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"

    :email_user    == params[:sender]
    :email_topic   == params[:subject]
    :email_bookmark == params['body-plain']
    # body_without_quotes = request.POST.get('stripped-text', '')
    # recipient = request.POST.get('recipient')
    if user_nil
      email_user = User.create(email: :email_user)
    end

    if topic_nil
      email_topic = Topic.create(title: :email_topic)
    end 

    create_a_bookmark(:email_user, :email_topic, :email_bookmark)
    
    head 200
  end

  def user_nil
    User.find_by(email: :email_user).nil?
  end 

  def topic_nil
    Topic.find_by(title: :email_topic).nil?
  end 

  def create_a_bookmark(email_user, email_topic, email_bookmark)
    User.find_by(email: :email_user).topics.find_by(title: :email_topic).bookmarks.create(url: :email_bookmark)
  end 
end
