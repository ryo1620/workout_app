require 'rails_helper'

RSpec.describe "Items", type: :system do
  
  let(:user) { create(:example) }
  
  before do
    admin = create(:admin)
    @pectoralis = create(:pectoralis)
    @bodyweight = create(:bodyweight)
    create(:pushup, user: admin, part: @pectoralis, type: @bodyweight)
    login_as(user)
    visit root_path
  end
  
  it 'creates a item' do
    click_link user.name
    click_link '種目一覧'
    expect(page).to have_css '.list-group-item'
    expect(page).to have_content 'プッシュアップ'
    
    click_link '新規作成'
    fill_in '種目名', with: ' '
    select '', from: 'メイン部位'
    select '', from: 'タイプ'
    click_button '作成'
    expect(page).to have_content '種目名を入力してください'
    expect(page).to have_content 'メイン部位を入力してください'
    expect(page).to have_content 'タイプを入力してください'
    
    fill_in '種目名', with: '腕立て伏せ'
    select '大胸筋', from: 'メイン部位'
    select '自重', from: 'タイプ'
    click_button '作成'
    expect(page).to have_content '種目を作成しました。'
    
    expect(page).to have_content '腕立て伏せ'
    expect(page).to have_content '大胸筋'
    expect(page).to have_content '自重'
    
    click_link '種目一覧へ戻る'
    expect(page).to have_content '腕立て伏せ'
  end
  
  it 'edits a item' do
    create(:udetate, user: user, part: @pectoralis, type: @bodyweight)
    click_link user.name
    click_link '種目一覧'
    click_link 'プッシュアップ'
    expect(page).not_to have_content '編集'
    
    click_link '種目一覧へ戻る'
    click_link '腕立て伏せ'
    click_link '編集'
    fill_in '種目名', with: '腕立て伏せ伏せ'
    click_button '更新'
    expect(page).to have_content '種目を更新しました。'
    expect(page).to have_content '腕立て伏せ伏せ'
  end
  
  it 'destroys a item' do
    create(:udetate, user: user, part: @pectoralis, type: @bodyweight)
    click_link user.name
    click_link '種目一覧'
    click_link 'プッシュアップ'
    expect(page).not_to have_content '種目を削除'
    
    click_link '種目一覧へ戻る'
    click_link '腕立て伏せ'
    click_link '種目を削除'
    expect(page.driver.browser.switch_to.alert.text).to eq "本当に種目を削除しますか？"
    page.driver.browser.switch_to.alert.dismiss
    
    click_link '種目を削除'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content '種目を削除しました。'
    expect(page).not_to have_content '腕立て伏せ'
  end
end