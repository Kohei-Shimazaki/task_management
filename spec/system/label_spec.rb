require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @label = FactoryBot.create(:label, user: @user)
    visit new_session_path
    fill_in 'Eメールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    sleep(1)
  end
  describe 'ラベル一覧画面' do
    context 'ラベルを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit labels_path
        expect(page).to have_content 'sample_label'
      end
      context '複数のタスクを作成した場合' do
        before do
          new_label = FactoryBot.create(:label, id: 2, title: 'new_label', user: @user)
          visit labels_path
        end
        it '作成済みのタスクが表示される' do
          expect(page).to have_content('sample_label', 'new_label')
        end
      end
    end
    context 'ラベルを削除した場合' do
      before do
        visit labels_path
        click_on '削除'
        page.accept_confirm
        sleep(1)
      end
      it '一覧から削除したラベルが消える' do
        expect(all('table tr').count).to eq 1
      end
    end
  end
  describe 'ラベル登録画面' do
    before do
      visit new_label_path
    end
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される,バリデーションが通る' do
        fill_in 'ラベル名', with: 'second_label'
        select '赤', from: '色'
        click_on 'ラベル登録'
        expect(page).to have_content('second_label', '赤')
      end
    end
    context 'データを入力せず、createボタンを押した場合' do
      it 'データが保存されず、バリデーションが通らない' do
        click_on 'ラベル登録'
        expect(page).to have_content('入力してください')
      end
    end
  end
  describe 'ラベル編集画面' do
    before do
      visit edit_label_path(1)
    end
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される,バリデーションが通る' do
        fill_in 'ラベル名', with: 'second_label'
        select '赤', from: '色'
        click_on 'ラベル登録'
        expect(page).to have_content('second_label', '赤')
      end
    end
    context 'データを入力せず、createボタンを押した場合' do
      it 'データが保存されず、バリデーションが通らない' do
        fill_in 'ラベル名', with: ''
        click_on 'ラベル登録'
        expect(page).to have_content('入力してください')
      end
    end
  end
end
