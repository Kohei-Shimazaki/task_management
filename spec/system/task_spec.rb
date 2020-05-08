require 'reils_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    before do
      visit
    end
    context 'タスクを作成した場合' do
      before do
        10times.do
          task = Task.create(
                            name: "name",
                            content: "content"
                            )
        end
      end
      it '作成済みのタスクが表示される' do
        expect(@tasks).to eq task
      end
    end
  end
