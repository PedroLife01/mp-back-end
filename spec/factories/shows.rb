FactoryBot.define do
  factory :show do
    name { "show-#{Time.now.to_i}" }
  end
end
