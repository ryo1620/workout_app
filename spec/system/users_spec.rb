require 'rails_helper'

RSpec.describe "Users", type: :system do
  
  it 'registers as a user with filling all input forms and signs in' do
    visit root_path
    click_link 'アカウント作成'
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
    
    click_link 'ログイン'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスの本人確認が必要です。'
    
    click_link 'ログイン'
    click_link 'アカウント確認のメールを受け取っていませんか？'
    fill_in 'メールアドレス', with: 'foo@example.com'
    expect { click_button 'アカウント確認メール再送' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content 'アカウントの有効化について数分以内にメールでご連絡します'
    
    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)
    expect(page).to have_content 'アカウントを作成しました。'
    
    click_link 'ログイン'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    
    click_link user.name
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
  
  it 'registers as a user without filling all input forms and' do
    visit root_path
    click_link 'アカウント作成'
    fill_in 'ユーザー名', with: ' '
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'ユーザー名を入力してください'
    
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: ' '
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'メールアドレスを入力してください'
    
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: ' '
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'パスワードを入力してください'
    
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: ' '
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
  end
  
  it 'changes password' do
    user = create(:example)
    visit root_path
    click_link 'ログイン'
    click_link 'パスワードを忘れましたか？'
    fill_in 'メールアドレス', with: 'example@example.com'
    expect { click_button 'パスワードの再設定方法を送信' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
    
    token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: token)
    fill_in '新しいパスワード', with: '12345678'
    fill_in '新しいパスワード（確認用）', with: '12345678'
    click_button 'パスワード変更'
    expect(page).to have_content 'パスワードが正しく変更されました。'
  end
  
  it 'edits a user account' do
    user = create(:example)
    login_as(user)
    visit root_path
    click_link user.name
    click_link 'アカウントの編集'
    fill_in '身長', with: '170'
    fill_in '体重', with: '70'
    fill_in '体脂肪率', with: '13.5'
    fill_in 'ベンチプレス', with: '100'
    fill_in 'スクワット', with: '140'
    fill_in 'デッドリフト', with: '180'
    fill_in '現在のパスワード', with: 'password'
    click_button '更新'
    expect(page).to have_content 'アカウント情報を変更しました。'
    
    visit user_path(user)
    expect(page).to have_content '170'
    expect(page).to have_content '70'
    expect(page).to have_content '13.5'
    expect(page).to have_content '100'
    expect(page).to have_content '140'
    expect(page).to have_content '180'
  end
end