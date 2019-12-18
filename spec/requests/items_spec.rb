require 'rails_helper'

RSpec.describe "Items", type: :request do
  include ApplicationHelper
  
  let(:user) { create(:admin) }
  let(:item) { create(:pushup, user: user, part: @pectoralis, type: @bodyweight) }
  before do
    @pectoralis = create(:pectoralis)
    @bodyweight = create(:bodyweight)
    login_as(user)
  end
  
  describe "GET /items" do
    before { get user_items_path(user) }
    it "should get /items" do
      expect(response).to have_http_status(:success)
    end
    it "has title '種目一覧 | WorkOut!!'" do
      expect(response.body).to include full_title('種目一覧')
    end
  end
  
  describe "GET /items/new" do
    before { get new_user_item_path(user) }
    it "should get /items/new" do
      expect(response).to have_http_status(:success)
    end
    it "has title '種目作成 | WorkOut!!'" do
      expect(response.body).to include full_title('種目作成')
    end
  end
  
  describe "GET /items/:id/edit" do
    before { get edit_user_item_path(user, item) }
    it "should get /items/:id/edit" do
      expect(response).to have_http_status(:success)
    end
    it "has title '種目の編集 | WorkOut!!'" do
      expect(response.body).to include full_title('種目の編集')
    end
  end
  
  describe "GET /items/:id" do
    before { get user_item_path(user, item) }
    it "should get /items/:id" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'item.name | WorkOut!!'" do
      expect(response.body).to include full_title(item.name)
    end
  end
end