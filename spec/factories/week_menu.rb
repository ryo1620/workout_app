FactoryBot.define do
  
  factory :sunday_menu, class: WeekMenu do
    cwday { 7 }
  end
  
  factory :today_menu1, class: WeekMenu do
    cwday { Date.today.cwday }
  end
  
  factory :today_menu2, class: WeekMenu do
    cwday { Date.today.cwday }
  end
  
  factory :today_menu3, class: WeekMenu do
    cwday { Date.today.cwday }
  end
  
  factory :tomorrow_menu1, class: WeekMenu do
    cwday { (Date.today + 1).cwday }
  end
end