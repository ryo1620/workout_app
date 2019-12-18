require 'rails_helper'

RSpec.describe "MenuItems", type: :request do
  include ApplicationHelper
  
  let(:user) { create(:admin) }
  let(:menu) { create(:munetore, user: user) }
  before { login_as(user) }
  
  describe "GET /menu_items" do
    before { get user_menu_menu_items_path(user, menu) }
    it "should get /menu_items" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'menu.name | WorkOut!!'" do
      expect(response.body).to include full_title(menu.name)
    end
  end
end