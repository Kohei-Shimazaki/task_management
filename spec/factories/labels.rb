FactoryBot.define do
  factory :label do
    id { 1 }
    title { "sample_label" }
    color { "blue" }
    shape { "square" }
    user
  end
end
