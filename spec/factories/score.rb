FactoryBot.define do
  factory :score do
    position "Yes"
    source_url "https://fancypolicy.gov"
    association :congress_member
  end
end
