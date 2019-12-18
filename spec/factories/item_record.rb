FactoryBot.define do
  
  factory :pushup_record, class: ItemRecord do
    name { "プッシュアップ" }
    date { Date.today }
  end
  
  factory :pushup_record_yesterday, class: ItemRecord do
    name { "プッシュアップ" }
    reps { 20 }
    sets { 5 }
    checked { true }
    date { Date.today - 1}
  end
  
  factory :dips_record_yesterday, class: ItemRecord do
    name { "ディップス" }
    weight { 10 }
    seconds { 30 }
    checked { true }
    date { Date.today - 1}
  end
end