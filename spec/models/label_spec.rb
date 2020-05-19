require 'rails_helper'

RSpec.describe Label, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  it 'titleが空ならバリデーションが通らない' do
    label = Label.new(color: 'blue', shape: 'arrow', user: @user)
    expect(label).not_to be_valid
  end
  it 'titleが16文字以上ならバリデーションが通らない' do
    label = Label.new(title: 'a'*16 , color: 'blue', shape: 'arrow', user: @user)
    expect(label).not_to be_valid
  end
end
