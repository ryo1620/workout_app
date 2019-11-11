# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者
User.create!(name: "Admin User",
             email: "admin@example.com",
             password: "password",
             confirmed_at: Time.now,
             admin: true)

#ユーザー
User.create!(name: "Example User",
             email: "example@example.com",
             password: "password",
             confirmed_at: Time.now)
             
#メニュー
Menu.create!(name: "胸トレ",
             user_id: "1")
             
Menu.create!(name: "脚トレ",
             user_id: "1")
             
Menu.create!(name: "背中トレ",
             user_id: "1")    