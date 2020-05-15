require 'rails_helper'
RSpec.describe 'ラベル一覧画面', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    visit new_session_path
    fill_in 'Eメールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    sleep(1)
  end
  describe 'ユーザ登録画面' do
  end
end
