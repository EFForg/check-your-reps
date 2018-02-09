FactoryBot.define do
  factory :rep do
    sequence(:bioguide_id) { |n| "A00000#{n}" }
    term_end (Time.now + 1.year).strftime("%Y-%m-%d")
    name "Buffy Summers"
    state "CA"

    factory :senator do
      chamber "senate"
    end

    factory :house_rep do
      chamber "house"
    end
  end
end
