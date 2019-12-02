FactoryBot.define do
  
  factory :menu_pushup, class: MenuItem do
    user_id { 1 }
    menu_id { 1 }
    item_id { 1 }
  end
  
  factory :menu_udetate, class: MenuItem do
    user_id { 1 }
    menu_id { 1 }
    item_id { 2 }
  end
end