require 'rails_helper'

RSpec.describe "SiteLayout", type: :system do
  xdescribe "layout links" do
    context "when not logged in" do
      before { visit root_path }
      subject { page }
      it { is_expected.to have_link "WorkOut!!", href: root_path }
      it { is_expected.to have_link "新規登録", href: signup_path }
      it { is_expected.to have_link "ログイン", href: login_path }
      it { is_expected.to have_link "WorkOut!!について", href: about_path }
      it { is_expected.to have_link "お問い合わせ", href: about_path }
    end
    context "when logged in (admin)" do
      before { visit root_path }
      subject { page }
      it { is_expected.to have_link "WorkOut!!", href: root_path }
      it { is_expected.to have_link "ユーザー一覧", href: users_path }
      it { is_expected.to have_link "メニュー管理", href: menus_path }
      it { is_expected.to have_link "種目管理", href: items_path }
      it { is_expected.to have_link "マイページ", href: user_path(user) }
      it { is_expected.to have_link "アカウント設定", href: edit_user_path(user) }
      it { is_expected.to have_link "ログアウト",　href: logout_path }
      it { is_expected.to have_link "WorkOut!!について", href: about_path }
      it { is_expected.to have_link "お問い合わせ", href: about_path }
    end
    context "when logged in (not admin)" do
      before { visit root_path }
      subject { page }
      it { is_expected.to have_link "WorkOut!!", href: root_path }
      it { is_expected.to_not have_link "ユーザー一覧", href: users_path }
      it { is_expected.to have_link "メニュー管理", href: menus_path }
      it { is_expected.to have_link "種目管理", href: items_path }
      it { is_expected.to have_link "マイページ", href: user_path(user) }
      it { is_expected.to have_link "アカウント設定", href: edit_user_path(user) }
      it { is_expected.to have_link "ログアウト",　href: logout_path }
      it { is_expected.to have_link "WorkOut!!について", href: about_path }
      it { is_expected.to have_link "お問い合わせ", href: about_path }
    end
  end
end