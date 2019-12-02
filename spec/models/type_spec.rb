require 'rails_helper'

RSpec.describe Type, type: :model do
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of type" do
    type = create(:bodyweight)
    expect(type).to be_valid
  end
end
