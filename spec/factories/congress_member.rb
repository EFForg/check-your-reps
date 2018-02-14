FactoryBot.define do
  factory :congress_member do
    sequence(:bioguide_id) { |n| "A00000#{n}" }
    term_end (Time.now + 1.year).strftime("%Y-%m-%d")
    name "Buffy Summers"
    chamber "senate"
    state "CA"

    factory :senator do
    end

    factory :representative do
      chamber "house"
    end

    factory :congress_member_with_score do
      after(:create) do |congress_member|
        FactoryBot.build(:score, congress_member_id: congress_member.id)
      end
    end
  end
end
