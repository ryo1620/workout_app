require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET /" do
    it "should get root" do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "should get about" do
      get '/about'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact" do
    it "should get contact" do
      get '/contact'
      expect(response).to have_http_status(:success)
    end
  end

end
