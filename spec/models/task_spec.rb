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
end
