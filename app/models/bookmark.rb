class Bookmark < ApplicationRecord
  validates :url, url: true 
  belongs_to :topic
end
