FactoryBot.define do
  
  factory :munetore_record, class: MenuRecord do
    name { "胸トレ" }
    date { Date.today }
    user_id { 1 }
  end
end