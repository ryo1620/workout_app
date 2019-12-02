require 'rails_helper'

RSpec.describe Part, type: :model do
  
  # factory_botが有効かどうかを検査
  it "has a valid factory of part" do
    part = create(:pectoralis)
    expect(part).to be_valid
  end
end
