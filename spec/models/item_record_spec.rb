require 'rails_helper'

RSpec.describe ItemRecord, type: :model do
  
  # 種目記録作成に必要なデータを作成
  before do
    @admin = create(:admin)
    @munetore_record = create(:munetore_record, user: @admin)
  end
  
  let(:item_record) { create(:pushup_record, user: @admin, menu_record: @munetore_record) }
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of item_record" do
    expect(item_record).to be_valid
  end
  
  # name, date, user_id, menu_record_idが無ければ無効
  it "is invalid without name" do
    item_record.name = " "
    expect(item_record).to be_invalid
  end
  it "is invalid without date" do
    item_record.date = " "
    expect(item_record).to be_invalid
  end
  it "is invalid without user_id" do
    item_record.user_id = " "
    expect(item_record).to be_invalid
  end
  it "is invalid without menu_record_id" do
    item_record.menu_record_id = " "
    expect(item_record).to be_invalid
  end
  
  # weight, reps, seconds, setsの値が大きすぎると無効
  it "is invalid with too heavy weight" do
    item_record.weight = 1000
    expect(item_record).to be_invalid
  end
  it "is invalid with too many reps" do
    item_record.reps = 1000
    expect(item_record).to be_invalid
  end
  it "is invalid with too many seconds" do
    item_record.seconds = 1000
    expect(item_record).to be_invalid
  end
  it "is invalid with too many sets" do
    item_record.sets = 1000
    expect(item_record).to be_invalid
  end
  
  # weight, reps, seconds, setsの値が0だと無効
  it "is invalid with 0 weight" do
    item_record.weight = 0
    expect(item_record).to be_invalid
  end
  it "is invalid with 0 reps" do
    item_record.reps = 0
    expect(item_record).to be_invalid
  end
  it "is invalid with 0 seconds" do
    item_record.seconds = 0
    expect(item_record).to be_invalid
  end
  it "is invalid with 0 sets" do
    item_record.sets = 0
    expect(item_record).to be_invalid
  end
  
  # weight, reps, seconds, setsに少数が含まれていれば無効
  it "is invalid with decimal weight" do
    item_record.weight = 0.5
    expect(item_record).to be_invalid
  end
  it "is invalid with decimal reps" do
    item_record.reps = 0.5
    expect(item_record).to be_invalid
  end
  it "is invalid with decimal seconds" do
    item_record.seconds = 0.5
    expect(item_record).to be_invalid
  end
  it "is invalid with decimal sets" do
    item_record.sets = 0.5
    expect(item_record).to be_invalid
  end
end
