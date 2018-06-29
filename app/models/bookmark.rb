class Bookmark < ApplicationRecord
  validates :url, url: true 
  belongs_to :topic
  belongs_to :user 
end
