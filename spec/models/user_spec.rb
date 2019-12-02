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
end