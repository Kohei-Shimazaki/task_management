require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task)
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'test_name' && 'test_content'
      end
      context '複数のタスクを作成した場合' do
        before do
          new_task = FactoryBot.create(:task, name: 'new_name', content: 'new_content')
        end
        it '作成済みのタスクが表示される' do
          visit tasks_path
          expect(page).to have_content 'test_name' && 'test_content' && 'new_name' && 'new_content'
        end
        it 'タスクが作成日時の降順に並んでいる' do
          visit tasks_path
          expect(all('table tr')[1]).to have_content 'new_name' && 'new_content'
          expect(all('table tr')[2]).to have_content 'test_name' && 'test_content'
        end
      end
    end
  end
  describe 'タスク登録画面' do
    before do
      visit new_task_path
    end
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される,バリデーションが通る' do
        fill_in 'タスク名', with: 'task_name'
        fill_in '内容', with: 'task_content'
        click_on '登録'
        expect(page).to have_content 'task_' && 'name' && 'content'
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         visit tasks_path
         click_on '詳細'
         expect(page).to have_content 'タスク詳細' && 'test_name' && 'test_content'
       end
     end
  end
end
