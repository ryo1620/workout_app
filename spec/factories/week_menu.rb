FactoryBot.define do
  
  factory :sunday_menu, class: WeekMenu do
    cwday { 7 }
    user_id { 1 }
    menu_id { 1 }
  end
end