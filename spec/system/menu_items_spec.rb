require 'rails_helper'

RSpec.describe "MenuItems", type: :system, js: true do
  
  let(:user) { create(:example) }
  
  before do
    admin = create(:admin)
    pectoralis = create(:pectoralis)
    bodyweight = create(:bodyweight)
    create(:pushup, user: admin, part: pectoralis, type: bodyweight)
    create(:udetate, user: user, part: pectoralis, type: bodyweight)
    login_as(user)
    visit root_path
  end
  
  it 'edits and resets menu_items' do
    click_link user.name
    click_link 'メニュー一覧'
    click_link '新規作成'
    
    fill_in 'メニュー名', with: '胸トレ'
    click_button '次へ'
    
    select 'プッシュアップ', from: 'menu_items_item_id1'
    fill_in 'menu_items_reps1', with: '20'
    fill_in 'menu_items_sets1', with: '5'
    select '腕立て伏せ', from: 'menu_items_item_id2'
    fill_in 'menu_items_weight2', with: '50'
    fill_in 'menu_items_seconds2', with: '300'
    click_button '保存'
    
    expect(page).to have_content 'メニュー内容を保存しました。'
    expect(page).to have_content 'プッシュアップ'
    expect(page).to have_content '20回'
    expect(page).to have_content '5セット'
    expect(page).to have_content '腕立て伏せ'
    expect(page).to have_content '50kg'
    expect(page).to have_content '300秒'
    
    click_link 'メニュー内容を編集'
    expect(page).to have_select('parts_types1', selected: '部位・タイプで選ぶ')
    expect(page).to have_select('menu_items_item_id1', selected: 'プッシュアップ')
    expect(page).to have_field 'menu_items_reps1', with: '20'
    expect(page).to have_field 'menu_items_sets1', with: '5'
    expect(page).to have_select('menu_items_item_id2', selected: '腕立て伏せ')
    expect(page).to have_field 'menu_items_weight2', with: '50'
    expect(page).to have_field 'menu_items_seconds2', with: '300'
    
    click_link 'メニュー内容をリセット'
    expect(page.driver.browser.switch_to.alert.text).to eq "本当にメニュー内容をリセットしますか？"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'メニュー内容をリセットしました。'
    expect(page).to have_select('menu_items_item_id1', selected: '')
    expect(page).to have_field 'menu_items_reps1', with: ''
    expect(page).to have_field 'menu_items_sets1', with: ''
    expect(page).to have_select('menu_items_item_id2', selected: '')
    expect(page).to have_field 'menu_items_weight2', with: ''
    expect(page).to have_field 'menu_items_seconds2', with: ''
    
    expect(page).not_to have_css '#parts_types20'
    click_button '次の10件を表示'
    expect(page).to have_css '#parts_types20'
    click_button '10件を非表示'
    expect(page).not_to have_css '#parts_types20'
    
    click_link 'メニューへ戻る'
    expect(page).to have_content 'メニュー内容は未登録です。'
  end
end