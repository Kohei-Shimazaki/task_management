FactoryBot.define do
  factory :task do
    name { 'test_name' }
    content { 'test_content' }
    deadline { Time.new(2020,5,10)}
    status { '未着手' }
    priority { 1 }
  end
end
