require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  let(:my_topic) { Topic.create!(title: Faker::ProgrammingLanguage ) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns [my_topic] to @topics' do 
      get :index 

      expect(assigns(:topics)).to eq([my_topic])
    end 
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: my_topic.id } 
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do 
      get :show, params: { id: my_topic.id }
      expect(response).to render_template :show 
    end
    
    it 'assigns my_topic to @topic' do 
      get :show, params: { id: my_topic.id }
      expect(assigns(:topic)).to eq(my_topic)
    end   
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new 
      expect(response).to render_template :new 
    end 
    
    it 'instantiates @topic' do 
      get :new 
      expect(assigns(:topic)).not_to be_nil 
    end  
  end

  describe 'POST create' do 

    it 'increases the number of Topic by 1' do
      expect{ post :create, params: { topic: {title: Faker::ProgrammingLanguage } } }
    end 
    
    it 'assigns the new topic to @topic' do 
      post :create, params: { topic: { title: Faker::ProgrammingLanguage } }
    end 
    
    it 'redirects to the new topic' do 
      post :create, params: { topic: { title: Faker::ProgrammingLanguage } }
      expect(response).to redirect_to Topic.last 
    end 
  end 

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
end 