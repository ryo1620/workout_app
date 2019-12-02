require 'rails_helper'

RSpec.describe "SiteLayout", type: :system do
  
  describe "layout links" do
    subject { page }
    
    context "when not signed in" do
      before { visit root_path }
      it { is_expected.to have_link "WorkOut!!", href: root_path }
      it { is_expected.to have_link "アカウント作成", href: new_user_registration_path }
      it { is_expected.to have_link "ログイン", href: new_user_session_path }
      it { is_expected.to have_link "WorkOut!!について", href: about_path }
      it { is_expected.to have_link "お問い合わせ", href: new_contact_path }
    end
    
    context "when signed in (not admin)" do
      let(:user){ create(:example) }
      before do
        login_as(user)
        visit root_path
        click_link user.name
      end
      it { is_expected.to have_link "WorkOut!!", href: root_path }
      it { is_expected.to_not have_link "ユーザー一覧", href: users_path }
      it { is_expected.to have_link "スケジュール管理", href: user_week_menus_path(user) }
      it { is_expected.to have_link "カレンダー", href: user_calendar_path(user) }
      it { is_expected.to have_link "メニュー一覧", href: user_menus_path(user) }
      it { is_expected.to have_link "種目一覧", href: user_items_path(user) }
      it { is_expected.to have_link "マイページ", href: user_path(user) }
      it { is_expected.to have_link "アカウントの編集", href: edit_user_registration_path(user) }
      it { is_expected.to have_link "ログアウト", href: destroy_user_session_path }
      it { is_expected.to have_link "WorkOut!!について", href: about_path }
      it { is_expected.to have_link "お問い合わせ", href: new_contact_path }
    end
    
    context "when signed in (admin)" do
      let(:user){ create(:admin) }
      before do
        login_as(user)
        visit root_path
      end
      it { is_expected.to have_link "ユーザー一覧", href: users_path }
    end
  end
end