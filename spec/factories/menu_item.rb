FactoryBot.define do
  
  factory :menu_pushup, class: MenuItem do
    reps { 20 }
    sets { 5 }
  end
  
  factory :menu_dips, class: MenuItem do
    weight { 10 }
    seconds { 30 }
  end
end