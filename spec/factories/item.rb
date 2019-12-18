FactoryBot.define do
  
  factory :pushup, class: Item do
    name { "プッシュアップ" }
    default { true }
  end
  
  factory :dips, class: Item do
    name { "ディップス" }
    default { true }
  end
  
  factory :udetate, class: Item do
    name { "腕立て伏せ" }
    default { false }
  end
end