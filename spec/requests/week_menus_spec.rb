require 'rails_helper'

RSpec.describe "WeekMenus", type: :request do
  include ApplicationHelper
  
  let(:user) { create(:admin) }
  before { login_as(user) }
  
  describe "GET /week_menus" do
    before { get user_week_menus_path(user) }
    it "should get /week_menus" do
      expect(response).to have_http_status(:success)
    end
    it "has title 'スケジュール管理 | WorkOut!!'" do
      expect(response.body).to include full_title('スケジュール管理')
    end
  end
end