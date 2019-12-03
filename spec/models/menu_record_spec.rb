require 'rails_helper'

RSpec.describe MenuRecord, type: :model do
  
  # メニュー記録作成に必要なデータを作成
  before do
    create(:admin)
  end
  
  let(:menu_record) { create(:munetore_record) }
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of menu_record" do
    expect(menu_record).to be_valid
  end
  
  # name, date, user_idが無ければ無効
  it "is invalid without name" do
    menu_record.name = " "
    expect(menu_record).to be_invalid
  end
  it "is invalid without date" do
    menu_record.date = " "
    expect(menu_record).to be_invalid
  end
  it "is invalid without user_id" do
    menu_record.user_id = " "
    expect(menu_record).to be_invalid
  end
end
