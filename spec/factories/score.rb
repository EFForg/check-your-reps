FactoryBot.define do
  factory :score do
    position "Yes"
    source_url "https://fancypolicy.gov"
    after(:build) do |score, evaluator|
      FactoryBot.build(:congress_member, score: score)
    end
  end
end
