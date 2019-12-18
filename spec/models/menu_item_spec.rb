require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  
  # メニュー種目作成に必要なデータを作成
  before do
    @admin = create(:admin)
    pectoralis = create(:pectoralis)
    bodyweight = create(:bodyweight)
    @munetore = create(:munetore, user: @admin)
    @pushup = create(:pushup, user: @admin, part: pectoralis, type: bodyweight)
  end
  
  let(:menu_item) { create(:menu_pushup, user: @admin, menu: @munetore, item: @pushup) }
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of menu_item" do
    expect(menu_item).to be_valid
  end
  
  # user_id, menu_id, item_idが無ければ無効
  it "is invalid without user_id" do
    menu_item.user_id = " "
    expect(menu_item).to be_invalid
  end
  it "is invalid without menu_id" do
    menu_item.menu_id = " "
    expect(menu_item).to be_invalid
  end
  it "is invalid without item_id" do
    menu_item.item_id = " "
    expect(menu_item).to be_invalid
  end
  
  # weight, reps, seconds, setsの値が大きすぎると無効
  it "is invalid with too heavy weight" do
    menu_item.weight = 1000
    menu_item.valid?
    expect(menu_item.errors[:weight]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too many reps" do
    menu_item.reps = 1000
    menu_item.valid?
    expect(menu_item.errors[:reps]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too many seconds" do
    menu_item.seconds = 1000
    menu_item.valid?
    expect(menu_item.errors[:seconds]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too many sets" do
    menu_item.sets = 1000
    menu_item.valid?
    expect(menu_item.errors[:sets]).to include("は1000より小さい値にしてください")
  end
  
  # weight, reps, seconds, setsの値が0だと無効
  it "is invalid with 0 weight" do
    menu_item.weight = 0
    menu_item.valid?
    expect(menu_item.errors[:weight]).to include("は0より大きい値にしてください")
  end
  it "is invalid with 0 reps" do
    menu_item.reps = 0
    menu_item.valid?
    expect(menu_item.errors[:reps]).to include("は0より大きい値にしてください")
  end
  it "is invalid with 0 seconds" do
    menu_item.seconds = 0
    menu_item.valid?
    expect(menu_item.errors[:seconds]).to include("は0より大きい値にしてください")
  end
  it "is invalid with 0 sets" do
    menu_item.sets = 0
    menu_item.valid?
    expect(menu_item.errors[:sets]).to include("は0より大きい値にしてください")
  end
  
  # weight, reps, seconds, setsに少数が含まれていれば無効
  it "is invalid with decimal weight" do
    menu_item.weight = 0.5
    menu_item.valid?
    expect(menu_item.errors[:weight]).to include("は整数で入力してください")
  end
  it "is invalid with decimal reps" do
    menu_item.reps = 0.5
    menu_item.valid?
    expect(menu_item.errors[:reps]).to include("は整数で入力してください")
  end
  it "is invalid with decimal seconds" do
    menu_item.seconds = 0.5
    menu_item.valid?
    expect(menu_item.errors[:seconds]).to include("は整数で入力してください")
  end
  it "is invalid with decimal sets" do
    menu_item.sets = 0.5
    menu_item.valid?
    expect(menu_item.errors[:sets]).to include("は整数で入力してください")
  end
end
