require 'rails_helper'

RSpec.describe Menu, type: :model do
  
  # メニュー作成に必要なデータを作成
  before { @admin = create(:admin) }
  
  let(:menu) { create(:munetore, user: @admin) }
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of menu" do
    expect(menu).to be_valid
  end
  
  # name, user_idが無ければ無効
  it "is invalid without name" do
    menu.name = " "
    menu.valid?
    expect(menu.errors[:name]).to include("を入力してください")
  end
  it "is invalid without user_id" do
    menu.user_id = " "
    expect(menu).to be_invalid
  end
  
  # nameが長すぎると無効
  it "is invalid with too long name" do
    menu.name = "a" * 16
    menu.valid?
    expect(menu.errors[:name]).to include("は15文字以内で入力してください")
  end
  
  describe "association" do
    
    context "with week_menu" do
      let(:week_menu) { create(:sunday_menu, user: @admin, menu: menu) }
      it "should destroy week_menu (depend on menu destroyed)" do
        menu
        week_menu
        my_week_menu = menu.week_menus
        expect(my_week_menu).not_to be_empty
        menu.destroy
        expect(WeekMenu.where(id: week_menu.id)).to be_empty
      end
    end
    
    context "with menu_item" do
      before do
        pectoralis = create(:pectoralis)
        bodyweight = create(:bodyweight)
        @pushup = create(:pushup, user: @admin, part: pectoralis, type: bodyweight)
      end
      let(:menu_item) { create(:menu_pushup, user: @admin, menu: menu, item: @pushup) }
      it "should destroy menu_item (depend on menu destroyed)" do
        menu
        menu_item
        my_menu_item = menu.menu_items
        expect(my_menu_item).not_to be_empty
        menu.destroy
        expect(MenuItem.where(id: menu_item.id)).to be_empty
      end
    end
  end
end
