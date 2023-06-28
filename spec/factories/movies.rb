FactoryBot.define do
  factory :movie do
    name { "movie-#{Time.now.to_i}" }
  end
end
