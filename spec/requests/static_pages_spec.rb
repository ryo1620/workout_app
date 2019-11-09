require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  include ApplicationHelper

  describe "GET /" do
    it "should get root" do
      get '/'
      expect(response).to have_http_status(:success)
    end
    it "has title 'WorkOut!!'" do
      expect(response.body).to include full_title('')
      expect(response.body).to_not include '| WorkOut!!'
    end
  end

  describe "GET /about" do
    it "should get about" do
      get '/about'
      expect(response).to have_http_status(:success)
    end
    it "has title 'WorkOut!!について | WorkOut!!'" do
      expect(response.body).to include full_title('WorkOut!!について')
    end
  end

  describe "GET /contact" do
    it "should get contact" do
      get '/contact'
      expect(response).to have_http_status(:success)
    end
    it "has title 'お問い合わせ | WorkOut!!'" do
      expect(response.body).to include full_title('お問い合わせ')
    end
  end

end
