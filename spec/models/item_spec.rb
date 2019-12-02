require 'rails_helper'

RSpec.describe Item, type: :model do
  
  # 種目作成に必要なデータを作成
  before do
    create(:admin)
    create(:example)
    create(:pectoralis)
    create(:bodyweight)
  end
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of item" do
    item = create(:pushup)
    expect(item).to be_valid
  end
  it "has a valid factory of another_item" do
    item = create(:udetate)
    expect(item).to be_valid
  end
  
  # name, user_id, part_id, type_idが無ければ無効
  it "is invalid without name" do
    item = Item.new(name: " ")
    item.valid?
    expect(item.errors[:name]).to include("を入力してください")
  end
  it "is invalid without user_id" do
    item = Item.new(user_id: " ")
    expect(item).to be_invalid
  end
  it "is invalid without part_id" do
    item = Item.new(part_id: " ")
    item.valid?
    expect(item.errors[:part]).to include("を入力してください")
  end
  it "is invalid without type_id" do
    item = Item.new(type_id: " ")
    item.valid?
    expect(item.errors[:type]).to include("を入力してください")
  end
  
  # nameが長すぎると無効
  it "is invalid with too long name" do
    item = Item.new(name: "a" * 31)
    item.valid?
    expect(item.errors[:name]).to include("は30文字以内で入力してください")
  end
end
