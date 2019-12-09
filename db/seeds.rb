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
             confirmed_at: Time.now,
             height: 170.0,
             body_weight: 60.0,
             body_fat: 15.0,
             bench_press: 80,
             squat: 100,
             deadlift: 120)

#メニュー
Menu.create!(name: "胸トレ",
             user_id: 2)
Menu.create!(name: "脚トレ",
             user_id: 2)
Menu.create!(name: "背中トレ",
             user_id: 2)
Menu.create!(name: "腹トレ",
             user_id: 2)
Menu.create!(name: "上腕トレ",
             user_id: 2)
Menu.create!(name: "肩トレ",
             user_id: 2)
Menu.create!(name: "前腕トレ",
             user_id: 2) 
Menu.create!(name: "ふくらはぎトレ",
             user_id: 2)   
Menu.create!(name: "僧帽トレ",
             user_id: 2)               
Menu.create!(name: "自重トレ",
             user_id: 2)
Menu.create!(name: "ダンベルトレ",
             user_id: 2)

Menu.create!(name: "胸トレ",
             user_id: 1)
Menu.create!(name: "脚トレ",
             user_id: 1)
Menu.create!(name: "背中トレ",
             user_id: 1)
Menu.create!(name: "腹トレ",
             user_id: 1)
Menu.create!(name: "上腕トレ",
             user_id: 1)
Menu.create!(name: "肩トレ",
             user_id: 1)
Menu.create!(name: "前腕トレ",
             user_id: 1) 
Menu.create!(name: "ふくらはぎトレ",
             user_id: 1)   
Menu.create!(name: "僧帽トレ",
             user_id: 1)               
Menu.create!(name: "自重トレ",
             user_id: 1)
Menu.create!(name: "ダンベルトレ",
             user_id: 1)  

#部位
Part.create!(name: "僧帽筋") #1 
Part.create!(name: "三角筋") #2
Part.create!(name: "大胸筋") #3
Part.create!(name: "上腕二頭筋") #4
Part.create!(name: "上腕三頭筋") #5
Part.create!(name: "前腕筋") #6
Part.create!(name: "腹筋") #7
Part.create!(name: "広背筋") #8
Part.create!(name: "脊柱起立筋") #9
Part.create!(name: "臀筋") #10
Part.create!(name: "大腿四頭筋") #11
Part.create!(name: "ハムストリングス") #12
Part.create!(name: "下腿三頭筋") #13

#タイプ
Type.create!(name: "バーベル") #1
Type.create!(name: "ダンベル") #2
Type.create!(name: "マシン") #3
Type.create!(name: "ケーブル") #4
Type.create!(name: "自重") #5
Type.create!(name: "その他") #6  

#種目
Item.create!(name: "ベンチプレス", default: true, user_id: 1, part_id: 3, type_id: 1)
Item.create!(name: "ダンベルプレス", default: true, user_id: 1, part_id: 3, type_id: 2)
Item.create!(name: "インクラインベンチプレス", default: true, user_id: 1, part_id: 3, type_id: 1)
Item.create!(name: "インクラインダンベルプレス", default: true, user_id: 1, part_id: 3, type_id: 2)
Item.create!(name: "ダンベルフライ", default: true, user_id: 1, part_id: 3, type_id: 2)
Item.create!(name: "マシンチェストプレス", default: true, user_id: 1, part_id: 3, type_id: 3)
Item.create!(name: "マシンフライ", default: true, user_id: 1, part_id: 3, type_id: 3)
Item.create!(name: "プッシュアップ", default: true, user_id: 1, part_id: 3, type_id: 5)
Item.create!(name: "ディップス", default: true, user_id: 1, part_id: 3, type_id: 5)
Item.create!(name: "ケーブルクロスオーバー", default: true, user_id: 1, part_id: 3, type_id: 4)

Item.create!(name: "スクワット", default: true, user_id: 1, part_id: 11, type_id: 5)
Item.create!(name: "バーベルスクワット", default: true, user_id: 1, part_id: 11, type_id: 1)
Item.create!(name: "ダンベルスクワット", default: true, user_id: 1, part_id: 11, type_id: 2)
Item.create!(name: "ブルガリアンスクワット", default: true, user_id: 1, part_id: 11, type_id: 5)
Item.create!(name: "シシースクワット", default: true, user_id: 1, part_id: 11, type_id: 5)
Item.create!(name: "レッグプレス", default: true, user_id: 1, part_id: 11, type_id: 3)
Item.create!(name: "レッグエクステンション", default: true, user_id: 1, part_id: 11, type_id: 3)
Item.create!(name: "ハックスクワット", default: true, user_id: 1, part_id: 11, type_id: 3)
Item.create!(name: "レッグカール", default: true, user_id: 1, part_id: 12, type_id: 3)

Item.create!(name: "デッドリフト", default: true, user_id: 1, part_id: 9, type_id: 1)
Item.create!(name: "ダンベルデッドリフト", default: true, user_id: 1, part_id: 9, type_id: 2)
Item.create!(name: "チンニング", default: true, user_id: 1, part_id: 8, type_id: 5)
Item.create!(name: "ラットプルダウン", default: true, user_id: 1, part_id: 8, type_id: 3)
Item.create!(name: "ワンハンドローイング", default: true, user_id: 1, part_id: 8, type_id: 2)
Item.create!(name: "ベントオーバーローイング", default: true, user_id: 1, part_id: 8, type_id: 1)
Item.create!(name: "シーテッドローイング", default: true, user_id: 1, part_id: 8, type_id: 3)
Item.create!(name: "バックエクステンション", default: true, user_id: 1, part_id: 9, type_id: 5)

Item.create!(name: "クランチ", default: true, user_id: 1, part_id: 7, type_id: 5)
Item.create!(name: "ツイストクランチ", default: true, user_id: 1, part_id: 7, type_id: 5)
Item.create!(name: "シットアップ", default: true, user_id: 1, part_id: 7, type_id: 5)
Item.create!(name: "レッグレイズ", default: true, user_id: 1, part_id: 7, type_id: 5)
Item.create!(name: "プランク", default: true, user_id: 1, part_id: 7, type_id: 5)
Item.create!(name: "ドラゴンフラッグ", default: true, user_id: 1, part_id: 7, type_id: 5)
Item.create!(name: "ケーブルクランチ", default: true, user_id: 1, part_id: 7, type_id: 4)
Item.create!(name: "アブローラー", default: true, user_id: 1, part_id: 7, type_id: 6)

Item.create!(name: "バーベルカール", default: true, user_id: 1, part_id: 4, type_id: 1)
Item.create!(name: "ダンベルカール", default: true, user_id: 1, part_id: 4, type_id: 2)
Item.create!(name: "ハンマーカール", default: true, user_id: 1, part_id: 4, type_id: 2)
Item.create!(name: "プリーチャーカール", default: true, user_id: 1, part_id: 4, type_id: 1)
Item.create!(name: "ケーブルカール", default: true, user_id: 1, part_id: 4, type_id: 4)
Item.create!(name: "チンアップ", default: true, user_id: 1, part_id: 4, type_id: 5)

Item.create!(name: "スカルクラッシャー", default: true, user_id: 1, part_id: 5, type_id: 1)
Item.create!(name: "ケーブルプレスダウン", default: true, user_id: 1, part_id: 5, type_id: 4)
Item.create!(name: "ケーブルフレンチプレス", default: true, user_id: 1, part_id: 5, type_id: 4)

Item.create!(name: "サイドレイズ", default: true, user_id: 1, part_id: 2, type_id: 2)
Item.create!(name: "フロントレイズ", default: true, user_id: 1, part_id: 2, type_id: 2)
Item.create!(name: "リアレイズ", default: true, user_id: 1, part_id: 2, type_id: 2)
Item.create!(name: "バーベルショルダープレス", default: true, user_id: 1, part_id: 2, type_id: 1)
Item.create!(name: "ダンベルショルダープレス", default: true, user_id: 1, part_id: 2, type_id: 2)
Item.create!(name: "マシンショルダープレス", default: true, user_id: 1, part_id: 2, type_id: 3)

Item.create!(name: "バーベルシュラッグ", default: true, user_id: 1, part_id: 1, type_id: 1)
Item.create!(name: "ダンベルシュラッグ", default: true, user_id: 1, part_id: 1, type_id: 2)
Item.create!(name: "ケーブルシュラッグ", default: true, user_id: 1, part_id: 1, type_id: 4)

Item.create!(name: "アブダクション", default: true, user_id: 1, part_id: 10, type_id: 3)
Item.create!(name: "ヒップエクステンション", default: true, user_id: 1, part_id: 10, type_id: 5)
Item.create!(name: "ヒップリフト", default: true, user_id: 1, part_id: 10, type_id: 5)

Item.create!(name: "バーベルリストカール", default: true, user_id: 1, part_id: 6, type_id: 1)
Item.create!(name: "ダンベルリストカール", default: true, user_id: 1, part_id: 6, type_id: 2)
Item.create!(name: "バーベルリバースリストカール", default: true, user_id: 1, part_id: 6, type_id: 1)
Item.create!(name: "ダンベルリバースリストカール", default: true, user_id: 1, part_id: 6, type_id: 2)

Item.create!(name: "スタンディングカーフレイズ", default: true, user_id: 1, part_id: 13, type_id: 5)
Item.create!(name: "シーテッドカーフレイズ", default: true, user_id: 1, part_id: 13, type_id: 5)
Item.create!(name: "ドンキーカーフレイズ", default: true, user_id: 1, part_id: 13, type_id: 5)

#メニュー種目
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 1, weight: 50, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 2, weight: 15, reps: 15, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 3, weight: 50, reps: 8, sets: 2)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 4, weight: 10, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 5, weight: 8, reps: 12, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 6, weight: 30, reps: 15, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 7, weight: 10, reps: 15, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 8, reps: 20, sets: 1)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 9, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 1, item_id: 10, weight: 5, reps: 15, sets: 4)

MenuItem.create!(user_id: 2, menu_id: 2, item_id: 11, reps: 20, sets: 1)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 12, weight: 70, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 13, weight: 20, reps: 15, sets: 2)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 14, reps: 10, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 15, reps: 8, sets: 2)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 16, weight: 100, reps: 10, sets: 2)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 17, weight: 30, reps: 12, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 18, weight: 60, reps: 8, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 2, item_id: 19, weight: 20, reps: 15, sets: 3)

MenuItem.create!(user_id: 2, menu_id: 3, item_id: 20, weight: 100, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 3, item_id: 21, weight: 30, reps: 12, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 3, item_id: 22, reps: 8, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 3, item_id: 23, weight: 30, reps: 12, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 3, item_id: 24, weight: 20, reps: 10, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 3, item_id: 25, weight: 40, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 3, item_id: 26, weight: 35, reps: 15, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 3, item_id: 27, reps: 15, sets: 4)

MenuItem.create!(user_id: 2, menu_id: 4, item_id: 28, reps: 30, sets: 5)
MenuItem.create!(user_id: 2, menu_id: 4, item_id: 29, reps: 15, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 4, item_id: 30, reps: 20, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 4, item_id: 31, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 4, item_id: 32, seconds: 60, sets: 1)
MenuItem.create!(user_id: 2, menu_id: 4, item_id: 33, reps: 3, sets: 2)
MenuItem.create!(user_id: 2, menu_id: 4, item_id: 34, weight: 30, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 4, item_id: 35, reps: 15, sets: 3)

MenuItem.create!(user_id: 2, menu_id: 5, item_id: 36, weight: 25, reps: 8, sets: 2)
MenuItem.create!(user_id: 2, menu_id: 5, item_id: 37, weight: 10, reps: 15, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 5, item_id: 38, weight: 8, reps: 12, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 5, item_id: 39, weight: 20, reps: 12, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 5, item_id: 40, weight: 15, reps: 15, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 5, item_id: 41, reps: 8, sets: 3)

MenuItem.create!(user_id: 2, menu_id: 6, item_id: 42, weight: 15, reps: 12, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 6, item_id: 43, weight: 25, reps: 15, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 6, item_id: 44, weight: 25, reps: 10, sets: 3)

MenuItem.create!(user_id: 2, menu_id: 7, item_id: 45, weight: 3, reps: 100, sets: 1)
MenuItem.create!(user_id: 2, menu_id: 7, item_id: 46, weight: 5, reps: 100, sets: 1)
MenuItem.create!(user_id: 2, menu_id: 7, item_id: 47, weight: 4, reps: 100, sets: 1)
MenuItem.create!(user_id: 2, menu_id: 7, item_id: 48, weight: 30, reps: 10, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 7, item_id: 49, weight: 15, reps: 12, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 7, item_id: 50, weight: 25, reps: 15, sets: 3)

MenuItem.create!(user_id: 2, menu_id: 8, item_id: 51, weight: 40, reps: 8, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 8, item_id: 52, weight: 20, reps: 12, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 8, item_id: 53, weight: 30, reps: 15, sets: 3)

MenuItem.create!(user_id: 2, menu_id: 9, item_id: 54, weight: 35, reps: 12, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 9, item_id: 55, reps: 15, sets: 5)
MenuItem.create!(user_id: 2, menu_id: 9, item_id: 56, reps: 20, sets: 5)

MenuItem.create!(user_id: 2, menu_id: 10, item_id: 57, weight: 20, reps: 8, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 10, item_id: 58, weight: 10, reps: 12, sets: 4)
MenuItem.create!(user_id: 2, menu_id: 10, item_id: 59, weight: 15, reps: 8, sets: 3)
MenuItem.create!(user_id: 2, menu_id: 10, item_id: 60, weight: 6, reps: 12, sets: 4)

MenuItem.create!(user_id: 2, menu_id: 11, item_id: 61, reps: 30, sets: 5)
MenuItem.create!(user_id: 2, menu_id: 11, item_id: 62, reps: 30, sets: 5)
MenuItem.create!(user_id: 2, menu_id: 11, item_id: 63, reps: 30, sets: 5)

#曜日メニュー
WeekMenu.create!(cwday: 2, user_id: 2, menu_id: 1)
WeekMenu.create!(cwday: 2, user_id: 2, menu_id: 5)

WeekMenu.create!(cwday: 4, user_id: 2, menu_id: 3)
WeekMenu.create!(cwday: 4, user_id: 2, menu_id: 7)
WeekMenu.create!(cwday: 4, user_id: 2, menu_id: 9)

WeekMenu.create!(cwday: 6, user_id: 2, menu_id: 2)
WeekMenu.create!(cwday: 6, user_id: 2, menu_id: 8)
WeekMenu.create!(cwday: 6, user_id: 2, menu_id: 4)

WeekMenu.create!(cwday: 7, user_id: 2, menu_id: 6)