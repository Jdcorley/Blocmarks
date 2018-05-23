require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let (:topic) { Post.new(title: 'Ruby on Rails') }
  let (:bookmark) { Bookmark.new(url: 'http://guides.rubyonrails.org' ) }

  describe 'attributes' do 
    it 'has a url attribute' do  
      expect(bookmark).to have_attributes(url: 'http://guides.rubyonrails.org' )
    end 
  end 
end
