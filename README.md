## 概要

WorkOut!!はトレーニングメニュー管理アプリケーションです。

## 機能・使用している技術の一覧

* トレーニングのメニューや種目を作成する機能

* 一週間のスケジュールを曜日ごとに管理する機能

* スケジュール管理やメニュー内容編集において、モデルを一括登録する機能

* メニュー内容編集において、Ajaxでセレクトボックスの中身を動的に変更する機能

* 種目一覧において、ドロップダウン検索により表示内容を絞り込む機能

* トップページに当日のメニューを表示し、チェックすることで記録を保存する機能
 
* カレンダーに過去の記録と未来のメニューを表示し、日付をクリックすることでその日のメニュー詳細を確認できる機能(FullCalendar)

* ユーザー作成・ログイン・認証機能(devise)

* ページネーション機能(kaminari)

* RSpec(モデル&コントローラテスト・E2Eテスト)

* Webpacker

* Bootstrap4

* SQLite(テスト&開発環境)・PostgreSQL(本番環境)