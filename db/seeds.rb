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