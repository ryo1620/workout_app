## 概要

WorkOut!!はトレーニングメニュー管理アプリケーションです。

## 機能・使用している主な技術の一覧

* トレーニングのメニューや種目を作成する機能

* 一週間のスケジュールを曜日ごとに管理する機能

* スケジュール管理画面やメニュー内容編集画面において、モデルを一括登録する機能

* メニュー内容編集画面において、Ajaxでセレクトボックスの中身を動的に変更する機能

* 種目一覧画面において、ドロップダウン検索により表示内容を絞り込む機能

* トップページに当日のメニューを表示し、チェックすることで記録を保存する機能
 
* カレンダーにメニューを表示し、日付をクリックすることで詳細を確認できる機能（FullCalendar）

* ユーザー作成・ログイン・認証機能（devise）

* 非同期ページネーション機能（kaminari）

* お問い合わせ（メール送信）機能
 
* Ruby（ver2.6.3）・Ruby on Rails（ver6.0.2）

* RSpec（モデル&コントローラテスト・E2Eテスト）

* Webpacker

* Bootstrap4

* Capistrano

* 開発環境: Docker Compose（Nginx + Puma + PostgreSQL）

* 本番環境: Amazon EC2（Nginx + Puma + PostgreSQL）