require 'rails_helper'

RSpec.describe User, type: :model do
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of user" do
    user = create(:admin)
    expect(user).to be_valid
  end
  it "has a valid factory of another_user" do
    user = create(:example)
    expect(user).to be_valid
  end
  
  let(:user) { create(:admin) }
  
  # name, email, passwordが無ければ無効
  it "is invalid without name" do
    user.name = " "
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  it "is invalid without email" do
    user.email = " "
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  it "is invalid without password" do
    user.password = " "
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  # name, emailが長すぎると無効
  it "is invalid with too long name" do
    user.name = "a" * 51
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end
  it "is invalid with too long email" do
    user.email = "a" * 244 + "@example.com"
    user.valid?
    expect(user.errors[:email]).to include("は255文字以内で入力してください")
  end
  
  # height, body_weight, body_fat, bench_press, squat, deadliftの値が大きすぎると無効
  it "is invalid with too large height" do
    user.height = 1000
    user.valid?
    expect(user.errors[:height]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too heavy body_weight" do
    user.body_weight = 1000
    user.valid?
    expect(user.errors[:body_weight]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too high body_fat" do
    user.body_fat = 100
    user.valid?
    expect(user.errors[:body_fat]).to include("は100より小さい値にしてください")
  end
  it "is invalid with too heavy bench_press" do
    user.bench_press = 1000
    user.valid?
    expect(user.errors[:bench_press]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too heavy squat" do
    user.squat = 1000
    user.valid?
    expect(user.errors[:squat]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too heavy deadlift" do
    user.deadlift = 1000
    user.valid?
    expect(user.errors[:deadlift]).to include("は1000より小さい値にしてください")
  end
  
  # bench_press, squat, deadliftに少数が含まれていれば無効
  it "is invalid with decimal bench_press" do
    user.bench_press = 80.5
    user.valid?
    expect(user.errors[:bench_press]).to include("は整数で入力してください")
  end
  it "is invalid with decimal squat" do
    user.squat = 80.5
    user.valid?
    expect(user.errors[:squat]).to include("は整数で入力してください")
  end
  it "is invalid with decimal deadlift" do
    user.deadlift = 80.5
    user.valid?
    expect(user.errors[:deadlift]).to include("は整数で入力してください")
  end
  
  describe "association" do
    
    context "with menu" do
      let(:menu) { create(:munetore) }
      it "should destroy menu (depend on user destroyed)" do
        user
        menu
        my_menu = user.menus
        expect(my_menu).not_to be_empty
        user.destroy
        expect(Menu.where(id: menu.id)).to be_empty
      end
    end
    
    context "with item" do
      before do
        create(:pectoralis)
        create(:bodyweight)
      end
      let(:item) { create(:pushup) }
      it "should destroy item (depend on user destroyed)" do
        user
        item
        my_item = user.items
        expect(my_item).not_to be_empty
        user.destroy
        expect(Item.where(id: item.id)).to be_empty
      end
    end
    
    context "with week_menu" do
      before do
        user
        create(:munetore)
      end
      let(:week_menu) { create(:sunday_menu) }
      it "should destroy week_menu (depend on user destroyed)" do
        week_menu
        my_week_menu = user.week_menus
        expect(my_week_menu).not_to be_empty
        user.destroy
        expect(WeekMenu.where(id: week_menu.id)).to be_empty
      end
    end
    
    context "with menu_item" do
      before do
        user
        create(:munetore)
        create(:pectoralis)
        create(:bodyweight)
        create(:pushup)
      end
      let(:menu_item) { create(:menu_pushup) }
      it "should destroy menu_item (depend on user destroyed)" do
        menu_item
        my_menu_item = user.menu_items
        expect(my_menu_item).not_to be_empty
        user.destroy
        expect(MenuItem.where(id: menu_item.id)).to be_empty
      end
    end
    
    context "with menu_record" do
      let(:menu_record) { create(:munetore_record) }
      it "should destroy menu_record (depend on user destroyed)" do
        user
        menu_record
        my_menu_record = user.menu_records
        expect(my_menu_record).not_to be_empty
        user.destroy
        expect(MenuRecord.where(id: menu_record.id)).to be_empty
      end
    end
    
    context "with item_record" do
      before do
        user
        create(:munetore_record)
      end
      let(:item_record) { create(:pushup_record) }
      it "should destroy item_record (depend on user destroyed)" do
        item_record
        my_item_record = user.item_records
        expect(my_item_record).not_to be_empty
        user.destroy
        expect(ItemRecord.where(id: item_record.id)).to be_empty
      end
    end
  end
end