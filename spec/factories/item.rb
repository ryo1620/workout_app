FactoryBot.define do
  
  factory :pushup, class: Item do
    name { "プッシュアップ" }
    default { true }
    user_id { 1 }
    part_id { 1 }
    type_id { 1 }
  end
  
  factory :udetate, class: Item do
    name { "腕立て伏せ" }
    default { false }
    user_id { 2 }
    part_id { 1 }
    type_id { 1 }
  end
end