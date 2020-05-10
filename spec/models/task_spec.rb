require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'titleが31文字以上ならバリデーションが通らない' do
    task = Task.new(name: 'a'*31 , content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'titleが1文字以上30字以内かつcontentに内容が記載去れていればバリデーションが通る' do
    task = Task.new(name: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end
  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(name: "task", content: "sample_task")
      Task.create(name: "sample", content: "sample_sample", status: "着手中")
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.search_like_name('task').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.search_status('未着手').count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.search_like_name('sample').search_status('着手中').count).to eq 1
    end
  end
end
