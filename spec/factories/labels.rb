FactoryBot.define do
  factory :label do
    id { 1 }
    title { "sample_label" }
    color { "青" }
    shape { "四角" }
    user
  end
end
