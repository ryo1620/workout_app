require 'rails_helper'

RSpec.describe WeekMenu, type: :model do
  
  # 曜日メニュー作成に必要なデータを作成
  before do
    @admin = create(:admin)
    @munetore = create(:munetore, user: @admin)
  end
  
  let(:week_menu) { create(:sunday_menu, user: @admin, menu: @munetore) }
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of week_menu" do
    expect(week_menu).to be_valid
  end
  
  # cwday, user_id, menu_idが無ければ無効
  it "is invalid without cwday" do
    week_menu.cwday = " "
    expect(week_menu).to be_invalid
  end
  it "is invalid without user_id" do
    week_menu.user_id = " "
    expect(week_menu).to be_invalid
  end
  it "is invalid without menu_id" do
    week_menu.menu_id = " "
    expect(week_menu).to be_invalid
  end
end
