FactoryBot.define do
  
  factory :sunday_menu, class: WeekMenu do
    cwday { 7 }
    user_id { 1 }
    menu_id { 1 }
  end
  
  factory :today_menu1, class: WeekMenu do
    cwday { Date.today.cwday }
    user_id { 1 }
    menu_id { 1 }
  end
  
  factory :today_menu2, class: WeekMenu do
    cwday { Date.today.cwday }
    user_id { 1 }
    menu_id { 2 }
  end
  
  factory :today_menu3, class: WeekMenu do
    cwday { Date.today.cwday }
    user_id { 1 }
    menu_id { 3 }
  end
  
  factory :tomorrow_menu1, class: WeekMenu do
    cwday { (Date.today + 1).cwday }
    user_id { 1 }
    menu_id { 3 }
  end
end