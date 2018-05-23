require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { Topic.new(title: 'Ruby on Rails') }
  
  describe 'attributes' do 
    it 'has a title attribute' do 
      expect(topic).to have_attributes(title: 'Ruby on Rails')
    end 
  end
end
