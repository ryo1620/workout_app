require 'rails_helper'

RSpec.describe Menu, type: :model do
  
  # メニュー作成に必要なデータを作成
  before { create(:admin) }
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of menu" do
    menu = create(:munetore)
    expect(menu).to be_valid
  end
  
  let(:menu) { create(:munetore) }
  
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
end
