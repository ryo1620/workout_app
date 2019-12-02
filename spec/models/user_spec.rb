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
  
  # name, email, passwordが無ければ無効
  it "is invalid without name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  it "is invalid without name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  it "is invalid without email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  it "is invalid without password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  # name, emailが長すぎると無効
  it "is invalid with too long name" do
    user = User.new(name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end
  it "is invalid with too long email" do
    user = User.new(email: "a" * 244 + "@example.com")
    user.valid?
    expect(user.errors[:email]).to include("は255文字以内で入力してください")
  end
  
  # height, body_weight, body_fat, bench_press, squat, deadliftの値が大きすぎると無効
  it "is invalid with too large height" do
    user = User.new(height: 1000)
    user.valid?
    expect(user.errors[:height]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too heavy body_weight" do
    user = User.new(body_weight: 1000)
    user.valid?
    expect(user.errors[:body_weight]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too high body_fat" do
    user = User.new(body_fat: 100)
    user.valid?
    expect(user.errors[:body_fat]).to include("は100より小さい値にしてください")
  end
  it "is invalid with too heavy bench_press" do
    user = User.new(bench_press: 1000)
    user.valid?
    expect(user.errors[:bench_press]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too heavy squat" do
    user = User.new(squat: 1000)
    user.valid?
    expect(user.errors[:squat]).to include("は1000より小さい値にしてください")
  end
  it "is invalid with too heavy deadlift" do
    user = User.new(deadlift: 1000)
    user.valid?
    expect(user.errors[:deadlift]).to include("は1000より小さい値にしてください")
  end
  
  # bench_press, squat, deadliftに少数が含まれていれば無効
  it "is invalid with decimal bench_press" do
    user = User.new(bench_press: 80.5)
    user.valid?
    expect(user.errors[:bench_press]).to include("は整数で入力してください")
  end
  it "is invalid with decimal squat" do
    user = User.new(squat: 80.5)
    user.valid?
    expect(user.errors[:squat]).to include("は整数で入力してください")
  end
  it "is invalid with decimal deadlift" do
    user = User.new(deadlift: 80.5)
    user.valid?
    expect(user.errors[:deadlift]).to include("は整数で入力してください")
  end
end
