FactoryBot.define do
  
  factory :menu_pushup, class: MenuItem do
    user_id { 1 }
    menu_id { 1 }
    item_id { 1 }
    reps { 20 }
    sets { 5 }
  end
  
  factory :menu_dips, class: MenuItem do
    user_id { 1 }
    menu_id { 1 }
    item_id { 2 }
    weight { 10 }
    seconds { 30 }
  end
end