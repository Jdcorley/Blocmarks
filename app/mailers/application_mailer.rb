class ApplicationMailer < Devise::Mailer < ActionMailer::Base 
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
end
