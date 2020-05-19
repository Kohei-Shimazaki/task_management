require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ登録画面' do
    before do
      visit new_user_path
    end
    context 'ユーザがログインしていない場合' do
      it 'ユーザの新規登録ができる' do
        fill_in 'ユーザ名', with: 'user_name'
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '登録'
        expect(User.all.count).to eq 1
      end
    end
    context 'ユーザがログインしている場合' do
      before do
        fill_in 'ユーザ名', with: 'new_name'
        fill_in 'Eメールアドレス', with: 'new@gmail.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '登録'
      end
      it 'ユーザ登録画面にアクセスできない' do
        expect(page).to have_content 'マイページ'
      end
    end
  end
  describe 'ログイン画面' do
    before do
      visit new_session_path
    end
    context 'アカウントがあり、ログインしていない場合' do
      before do
        user = create(:user)
      end
      it 'ログインできる' do
        fill_in 'Eメールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        sleep(1)
        expect(page).to have_content 'ログアウト'
      end
    end
    context 'アカウントがあり、ログインしている場合' do
      before do
        user = create(:user)
        other_user = create(:user, id: 3, email: 'other@example.com')
        fill_in 'Eメールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        sleep(1)
        visit tasks_path
      end
      it 'マイページにアクセスできる' do
        visit user_path(1)
        expect(page).to have_content 'マイページ'
      end
      it '一般ユーザが他人のマイページにアクセスするとタスク一覧へ遷移する' do
        visit user_path(3)
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトできる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン'
      end
    end
    context 'ログインしていない場合' do
      it 'タスク一覧ページにアクセスするとログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログインはこの画面からお願いします。' && 'サインアップ'
      end
    end
  end
  describe '管理画面' do
    context '管理者としてログインしている場合' do
      before do
        admin = create(:admin_user)
        user = create(:user)
        visit new_session_path
        fill_in 'Eメールアドレス', with: 'admin@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        sleep(1)
      end
      it 'ユーザ管理画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content 'タスク数'
      end
      it 'ユーザを新規登録できる' do
        visit new_admin_user_path
        fill_in 'ユーザ名', with: 'user_name'
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '登録'
        expect(User.all.count).to eq 3
      end
      it 'ユーザの詳細画面にアクセスできる' do
        visit admin_user_path(1)
        expect(page).to have_content 'sample'
      end
      it 'ユーザの編集画面からユーザを編集できる' do
        visit edit_admin_user_path(1)
        fill_in 'ユーザ名', with: 'new_user_name'
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        select '有', from: '管理者権限'
        click_on '登録'
        sleep(1)
        expect(page).to have_content 'new_'
      end
      it 'ユーザの削除ができる' do
        visit admin_users_path
        within all('table tr')[2] do
          click_on 'ユーザ削除'
        end
        page.accept_confirm
        sleep(1)
        expect(User.all.count).to eq 1
      end
    end
    context '管理者権限のないユーザとしてログインしている場合' do
      before do
        user = create(:user)
        visit new_session_path
        fill_in 'Eメールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        sleep(1)
      end
      it '管理画面にアクセスするとタスク一覧に遷移する' do
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end
  end
end
