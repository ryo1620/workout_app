require 'rails_helper'

RSpec.describe "SignUp", type: :system do
  
  before do
    ActionMailer::Base.deliveries.clear
  end
  
  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end
  
  it 'registers as a user with filling all input forms and signs in' do
    visit root_path
    click_link 'アカウント作成'
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
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
  
  it 'registers as a user without filling all input forms' do
    visit root_path
    click_link 'アカウント作成'
    fill_in 'ユーザー名', with: ''
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'ユーザー名を入力してください'
    
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'メールアドレスを入力してください'
    
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: ''
    fill_in 'パスワード（確認用）', with: 'password'
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'パスワードを入力してください'
    
    fill_in 'ユーザー名', with: 'foobar'
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: ''
    expect { click_button 'アカウント作成' }.not_to change { ActionMailer::Base.deliveries.size }
    expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
  end
end