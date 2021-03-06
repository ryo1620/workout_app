require 'rails_helper'

RSpec.describe Item, type: :model do
  
  # 種目作成に必要なデータを作成
  before do
    @admin = create(:admin)
    @example = create(:example)
    @pectoralis = create(:pectoralis)
    @bodyweight = create(:bodyweight)
  end
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of item" do
    item = create(:pushup, user: @admin, part: @pectoralis, type: @bodyweight)
    expect(item).to be_valid
  end
  it "has a valid factory of another_item" do
    item = create(:udetate, user: @example, part: @pectoralis, type: @bodyweight)
    expect(item).to be_valid
  end
  
  let(:item) { create(:pushup, user: @admin, part: @pectoralis, type: @bodyweight) }
  
  # name, user_id, part_id, type_idが無ければ無効
  it "is invalid without name" do
    item.name = " "
    item.valid?
    expect(item.errors[:name]).to include("を入力してください")
  end
  it "is invalid without user_id" do
    item.user_id = " "
    expect(item).to be_invalid
  end
  it "is invalid without part_id" do
    item.part_id = " "
    item.valid?
    expect(item.errors[:part]).to include("を入力してください")
  end
  it "is invalid without type_id" do
    item.type_id = " "
    item.valid?
    expect(item.errors[:type]).to include("を入力してください")
  end
  
  # nameが長すぎると無効
  it "is invalid with too long name" do
    item.name = "a" * 31
    item.valid?
    expect(item.errors[:name]).to include("は30文字以内で入力してください")
  end
  
  describe "association with menu_item" do
    before { @munetore = create(:munetore, user: @example) }
    let(:menu_item) { create(:menu_pushup, user: @example, menu: @munetore, item: item) }
    it "should destroy menu_item (depend on item destroyed)" do
      item
      menu_item
      my_menu_item = item.menu_items
      expect(my_menu_item).not_to be_empty
      item.destroy
      expect(MenuItem.where(id: menu_item.id)).to be_empty
    end
  end
end
