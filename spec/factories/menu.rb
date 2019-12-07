FactoryBot.define do
  
  factory :munetore, class: Menu do
    name { "胸トレ" }
    user_id { 1 }
  end
  
  factory :ashitore, class: Menu do
    name { "脚トレ" }
    user_id { 1 }
  end
  
  factory :senakatore, class: Menu do
    name { "背中トレ" }
    user_id { 1 }
  end
end