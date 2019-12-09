FactoryBot.define do
  
  factory :munetore_record, class: MenuRecord do
    name { "胸トレ" }
    date { Date.today }
    user_id { 1 }
  end
  
  factory :munetore_record_yesterday, class: MenuRecord do
    name { "胸トレ" }
    checked { true }
    date { Date.today - 1 }
    user_id { 1 }
  end
  
  factory :ashitore_record_yesterday, class: MenuRecord do
    name { "脚トレ" }
    checked { true }
    date { Date.today - 1 }
    user_id { 1 }
  end
end