require 'rails_helper'

RSpec.describe Contact, type: :model do
  
  let(:contact) { create(:contact) }
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of contact" do
    expect(contact).to be_valid
  end
  
  # email, messageが無ければ無効
  it "is invalid without email" do
    contact.email = " "
    contact.valid?
    expect(contact.errors[:email]).to include("を入力してください")
  end
  it "is invalid without message" do
    contact.message = " "
    contact.valid?
    expect(contact.errors[:message]).to include("を入力してください")
  end
  
  # emailが長すぎると無効
  it "is invalid with too long email" do
    contact.email = "a" * 244 + "@example.com"
    contact.valid?
    expect(contact.errors[:email]).to include("は255文字以内で入力してください")
  end
  
  # 有効なemailの型を受け入れる
  it "should accept valid emails" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
      contact.email = valid_email
      expect(contact).to be_valid
    end
  end
      
  # 無効なemailの型を受け入れない
  it "should not accept invalid emails" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_emails.each do |invalid_email|
      contact.email = invalid_email
      expect(contact).to be_invalid
    end
  end
end
