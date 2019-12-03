FactoryBot.define do
  
  factory :pushup_record, class: ItemRecord do
    name { "プッシュアップ" }
    date { Date.today }
    user_id { 1 }
    menu_record_id { 1 }
  end
end