require 'rails_helper'

RSpec.describe "Menus", type: :request do
  include ApplicationHelper
  
  let(:user) { create(:admin) }
  let(:menu) { create(:munetore) }
  before { login_as(user) }
  
  describe "GET /menus" do
    before { get user_menus_path(user) }
    it "should get /menus" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'メニュー一覧 | WorkOut!!'" do
      expect(response.body).to include full_title('メニュー一覧')
    end
  end
  
  describe "GET /menus" do
    before { get user_menus_path(user) }
    it "should get /menus" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'メニュー一覧 | WorkOut!!'" do
      expect(response.body).to include full_title('メニュー一覧')
    end
  end
  
  describe "GET /menus/new" do
    before { get new_user_menu_path(user) }
    it "should get /menus/new" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'メニュー作成 | WorkOut!!'" do
      expect(response.body).to include full_title('メニュー作成')
    end
  end
  
  describe "GET /menus/:id/edit" do
    before { get edit_user_menu_path(user, menu) }
    it "should get /menus/:id/edit" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'メニュー名の編集 | WorkOut!!'" do
      expect(response.body).to include full_title('メニュー名の編集')
    end
  end
  
  describe "GET /menus/:id" do
    before { get user_menu_path(user, menu) }
    it "should get /menus/:id" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'menu.name | WorkOut!!'" do
      expect(response.body).to include full_title(menu.name)
    end
  end
end