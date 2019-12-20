require 'rails_helper'

RSpec.describe "Records", type: :system, js: true do
  
  let(:user) { create(:example) }
  
  before do
    login_as(user)
    pectoralis = create(:pectoralis)
    bodyweight = create(:bodyweight)
    munetore = create(:munetore, user: user)
    ashitore = create(:ashitore, user: user)
    @senakatore = create(:senakatore, user: user)
    pushup = create(:pushup, user: user, part: pectoralis, type: bodyweight)
    dips = create(:dips, user: user, part: pectoralis, type: bodyweight)
    create(:menu_pushup, user: user, menu: munetore, item: pushup)
    create(:menu_dips, user: user, menu: munetore, item: dips)
    create(:today_menu1, user: user, menu: munetore)
    create(:today_menu2, user: user, menu: ashitore)
    create(:tomorrow_menu1, user: user, menu: @senakatore)
    munetore_record_yesterday = create(:munetore_record_yesterday, user: user)
    create(:ashitore_record_yesterday, user: user)
    create(:pushup_record_yesterday, user: user, menu_record: munetore_record_yesterday)
    create(:dips_record_yesterday, user: user, menu_record: munetore_record_yesterday)
  end
  
  it 'creates records once a day when a user visits root_path' do
    expect(user.menu_records.where(date: Date.today)).to be_empty
    expect(user.item_records.where(date: Date.today)).to be_empty
    visit root_path
    expect(user.menu_records.where(date: Date.today)).not_to be_empty
    expect(user.item_records.where(date: Date.today)).not_to be_empty
  end
  
  it 'edits a record when a user switches the checkbox' do
    visit root_path
    expect(page).to have_content '0%'
    expect(user.item_records.find_by(name: "プッシュアップ", date: Date.today).checked).to be false
    find('label', text: "プッシュアップ").click
    expect(page).to have_content '33%'
    expect(user.item_records.find_by(name: "プッシュアップ", date: Date.today).checked).to be true
    
    # リロードしても達成率が維持されるかどうか確認
    visit current_path
    expect(page).to have_content '33%'
    
    find('label', text: "プッシュアップ").click
    expect(page).to have_content '0%'
    expect(user.item_records.find_by(name: "プッシュアップ", date: Date.today).checked).to be false
    
    click_link '全てチェック'
    find('label', text: "脚トレ").click
    expect(page).to have_content '100%'
    expect(user.item_records.find_by(name: "プッシュアップ", date: Date.today).checked).to be true
    expect(user.item_records.find_by(name: "ディップス", date: Date.today).checked).to be true
    expect(user.menu_records.find_by(name: "脚トレ", date: Date.today).checked).to be true
    
    click_link '全てアンチェック'
    find('label', text: "脚トレ").click
    expect(page).to have_content '0%'
    expect(user.item_records.find_by(name: "プッシュアップ", date: Date.today).checked).to be false
    expect(user.item_records.find_by(name: "ディップス", date: Date.today).checked).to be false
    expect(user.menu_records.find_by(name: "脚トレ", date: Date.today).checked).to be false
    
    create(:today_menu3, user: user, menu: @senakatore)
    click_link '現在のスケジュールで上書き'
    expect(page.driver.browser.switch_to.alert.text).to eq "本当にメニューを上書きしますか？"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'メニューを上書きしました。'
    expect(page).to have_content '背中トレ'
  end
  
  it 'shows past records and future menus' do
    visit root_path
    find('a.left').click
    expect(page).to have_content '100%'
    expect(user.item_records.find_by(name: "プッシュアップ", date: Date.today - 1).checked).to be true
    expect(user.item_records.find_by(name: "ディップス", date: Date.today - 1).checked).to be true
    expect(user.menu_records.find_by(name: "脚トレ", date: Date.today - 1).checked).to be true
    
    find('a.left').click
    expect(page).to have_content 'この日はお休みでした。'
    
    click_link '今日のメニューへ戻る'
    find('a.right').click
    expect(page).to have_content '背中トレ'
    expect(page).not_to have_content '達成率'
    expect(page).not_to have_css 'form'
    
    find('a.right').click
    expect(page).to have_content 'この日はお休みです。'
  end
  
  it "shows a calendar and links to records or menus of the day" do
    visit root_path
    click_link user.name
    click_link 'カレンダー'
    # メニュー名が属するcssが表示されるまで待機する
    wait_for_css_appear('span.fc-title', 5) do
      expect(page).to have_content '胸トレ'
      expect(page).to have_content '脚トレ'
      expect(page).to have_content '背中トレ'
    end
    
    # カレンダーの前日部分をクリックし、前日のメニュー表示に切り替わることを確認
    first("td[data-date='#{(Date.today - 1).to_s}']").click
    expect(page).to have_content (Date.today - 1).strftime("%-m月%-d日") + "(#{%w(日 月 火 水 木 金 土)[(Date.today - 1).wday]})のメニュー"
    expect(page).to have_content '100%'
    expect(page).to have_content '胸トレ'
    expect(page).to have_content 'プッシュアップ'
    expect(page).to have_content 'ディップス'
    expect(page).to have_content '脚トレ'
    
    # カレンダーの当日部分をクリックし、当日のメニュー表示に切り替わることを確認
    click_link 'カレンダーへ戻る'
    first("td[data-date='#{Date.today.to_s}']").click
    expect(page).to have_content '今日のメニュー'
    expect(page).to have_content '0%'
    expect(page).to have_content '胸トレ'
    expect(page).to have_content 'プッシュアップ'
    expect(page).to have_content 'ディップス'
    expect(page).to have_content '脚トレ'
    
    # カレンダーの翌日部分をクリックし、翌日のメニュー表示に切り替わることを確認
    click_link 'カレンダーへ戻る'
    first("td[data-date='#{(Date.today + 1).to_s}']").click
    expect(page).to have_content (Date.today + 1).strftime("%-m月%-d日") + "(#{%w(日 月 火 水 木 金 土)[(Date.today + 1).wday]})のメニュー"
    expect(page).not_to have_content '達成率'
    expect(page).to have_content '背中トレ'
  end
end