FactoryBot.define do
  
  factory :admin, class: User do
    name { "admin" }
    email { "admin@example.com" }
    password { "password" }
    confirmed_at { Time.now }
    admin { true }
  end
  
  factory :example, class: User do
    name { "example" }
    email { "example@example.com" }
    password { "password" }
    confirmed_at { Time.now }
    admin { false }
  end
end