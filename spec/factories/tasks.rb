FactoryBot.define do
  factory :task do
    name { 'test_name' }
    content { 'test_content' }
    deadline { Time.current + 3 * 60 * 60 * 24 + 30 }
    status { '未着手' }
    priority { 1 }
    user
  end
end
