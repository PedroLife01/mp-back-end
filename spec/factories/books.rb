FactoryBot.define do
  factory :book do
    name { "book-#{Time.now.to_i}" }
  end
end
