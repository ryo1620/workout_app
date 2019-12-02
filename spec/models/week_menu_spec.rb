require 'rails_helper'

RSpec.describe WeekMenu, type: :model do
  
  # 曜日メニュー作成に必要なデータを作成
  before do
    create(:admin)
    create(:pectoralis)
    create(:bodyweight)
    create(:pushup)
    create(:munetore)
  end
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of week_menu" do
    week_menu = create(:sunday_menu)
    expect(week_menu).to be_valid
  end
  
  let(:week_menu) { create(:sunday_menu) }
  
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
