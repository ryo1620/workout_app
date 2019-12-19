require 'rails_helper'

RSpec.describe "Menus", type: :system, js: true do
  
  let(:user) { create(:example) }
  
  before do
    login_as(user)
    visit root_path
  end
  
  it 'creates a menu' do
    click_link user.name
    click_link 'メニュー一覧'
    expect(page).not_to have_css '.list-group-item'
    
    click_link '新規作成'
    fill_in 'メニュー名', with: ' '
    expect { click_button '次へ' }.not_to change { user.menus.count }
    expect(page).to have_content 'メニュー名を入力してください'
    fill_in 'メニュー名', with: '胸トレ'
    click_button '次へ'
    
    click_link 'メニューへ戻る'
    expect(page).to have_content '胸トレ'
    expect(page).to have_content 'メニュー内容は未登録です。'
    
    click_link 'メニュー一覧へ戻る'
    expect(page).to have_css '.list-group-item'
    expect(page).to have_content '胸トレ'
  end
  
  it 'edits a menu name' do
    create(:munetore, user: user)
    click_link user.name
    click_link 'メニュー一覧'
    click_link '胸トレ'
    click_link 'メニュー名を編集'
    fill_in 'メニュー名', with: '胸トレーニング'
    click_button '更新'
    expect(page).to have_content 'メニュー名を更新しました。'
    expect(page).to have_content '胸トレーニング'
  end
  
  it 'destroys a menu' do
    create(:munetore, user: user)
    click_link user.name
    click_link 'メニュー一覧'
    click_link '胸トレ'
    click_link 'メニューを削除'
    expect(page.driver.browser.switch_to.alert.text).to eq "本当にメニューを削除しますか？"
    page.driver.browser.switch_to.alert.dismiss
    
    click_link 'メニューを削除'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'メニューを削除しました。'
    expect(page).not_to have_css '.list-group-item'
  end
end