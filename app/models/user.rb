class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics
  has_many :bookmarks 
end
