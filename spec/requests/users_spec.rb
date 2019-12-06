require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  include ApplicationHelper
  
  let(:user) { create(:example) }
  
  describe "GET /users/sign_in" do
    before { get '/users/sign_in' }
    it "should get /users/sign_in" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'ログイン | WorkOut!!'" do
      expect(response.body).to include full_title('ログイン')
    end
  end
  
  describe "GET /users/password/new" do
    before { get '/users/password/new' }
    it "should get /users/password/new" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'パスワードを忘れましたか？ | WorkOut!!'" do
      expect(response.body).to include full_title('パスワードを忘れましたか？')
    end
  end
  
  describe "GET /users/sign_up" do
    before { get '/users/sign_up' }
    it "should get /users/sign_up" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'アカウント作成 | WorkOut!!'" do
      expect(response.body).to include full_title('アカウント作成')
    end
  end
  
  describe "GET /users/edit" do
    before do
      login_as(user)
      get edit_user_registration_path(user)
    end
    it "should get /users/edit" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'アカウントの編集 | WorkOut!!'" do
      expect(response.body).to include full_title('アカウントの編集')
    end
  end
  
  describe "GET /users/confirmation/new" do
    before { get '/users/confirmation/new' }
    it "should get /users/confirmation/new" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'アカウント確認メール再送 | WorkOut!!'" do
      expect(response.body).to include full_title('アカウント確認メール再送')
    end
  end
  
  describe "GET /users" do
    before do
      admin = create(:admin)
      login_as(admin)
      get '/users'
    end
    it "should get /users" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'ユーザー一覧 | WorkOut!!'" do
      expect(response.body).to include full_title('ユーザー一覧')
    end
  end
  
  describe "GET /users/:id" do
    before do
      login_as(user)
      get user_path(user)
    end
    it "should get /users/:id" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'user.name | WorkOut!!'" do
      expect(response.body).to include full_title(user.name)
    end
  end
end
