FactoryBot.define do
  factory :congress_member do
    sequence(:bioguide_id) { |n| "C0010#{n+34}" }
    term_end (Time.now + 1.year).strftime("%Y-%m-%d")
    sequence(:name) { |n| "Buffy Summers the #{n}#{n.ordinal}" }
    chamber "senate"
    state "CA"

    factory :senator do
    end

    factory :representative do
      chamber "house"
    end
  end
end
