require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  include ApplicationHelper

  describe "GET /" do
    before { get '/' }
    it "should get root" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'WorkOut!!'" do
      expect(response.body).to include full_title('')
      expect(response.body).to_not include '| WorkOut!!'
    end
  end

  describe "GET /about" do
    before { get '/about' }
    it "should get about" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'WorkOut!!について | WorkOut!!'" do
      expect(response.body).to include full_title('WorkOut!!について')
    end
  end

  describe "GET /contact" do
    before { get '/contact' }
    it "should get contact" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'お問い合わせ | WorkOut!!'" do
      expect(response.body).to include full_title('お問い合わせ')
    end
  end
  
  describe "GET /calendar" do
    before do
      user = create(:example)
      login_as(user)
      get user_calendar_path(user)
    end
    it "should get calendar" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'カレンダー | WorkOut!!'" do
      expect(response.body).to include full_title('カレンダー')
    end
  end
end
