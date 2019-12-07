require 'rails_helper'

RSpec.describe "WeekMenus", type: :system do
  
  let(:user) { create(:example) }
  
  before do
    login_as(user)
    visit root_path
  end
  
  it 'edits and resets week_menus' do
    create(:munetore)
    create(:ashitore)
    create(:senakatore)
    click_link user.name
    click_link 'スケジュール管理'
    
    select '胸トレ', from: 'week_menus1_1'
    select '脚トレ', from: 'week_menus1_2'
    select '背中トレ', from: 'week_menus1_3'
    select '胸トレ', from: 'week_menus7_3'
    click_button '更新'
    
    expect(page).to have_content 'スケジュールを更新しました。'
    expect(page).to have_select('week_menus1_1', selected: '胸トレ')
    expect(page).to have_select('week_menus1_2', selected: '脚トレ')
    expect(page).to have_select('week_menus1_3', selected: '背中トレ')
    expect(page).to have_select('week_menus7_1', selected: '胸トレ')
    click_link 'リセット'
    expect(page.driver.browser.switch_to.alert.text).to eq "本当にスケジュールをリセットしますか？"
    page.driver.browser.switch_to.alert.dismiss
    
    click_link 'リセット'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'スケジュールをリセットしました。'
    expect(page).to have_select('week_menus1_1', selected: '')
    expect(page).to have_select('week_menus1_2', selected: '')
    expect(page).to have_select('week_menus1_3', selected: '')
    expect(page).to have_select('week_menus7_1', selected: '')
  end
end