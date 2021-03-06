# frozen_string_literal: true
namespace :congress do
  desc "Create/update records of Congress members"
  task update: :environment do
    legislator_sources =
      [
        "https://raw.githubusercontent.com/unitedstates/congress-legislators/master/legislators-current.yaml",
        "https://raw.githubusercontent.com/unitedstates/congress-legislators/master/legislators-historical.yaml"
      ]

    social_media = RestClient.get(
      "https://raw.githubusercontent.com/unitedstates/congress-legislators/master/legislators-social-media.yaml"
    )

    legislator_sources.each do |repo|
      data = RestClient.get(repo)
      YAML.load(data).each do |info|
        term = info["terms"].last
        next if term["start"] < "2011-01-01" # don't get too historical

        full_name = info["name"]["official_full"] || "#{info['name']['first']} #{info['name']['last']}"

        attributes = {
          name:        full_name,
          bioguide_id: info["id"]["bioguide"],
          term_end:    term["end"],
          chamber:     term["type"] == "sen" ? "senate" : "house",
          state:       term["state"],
          district:    term["district"].try(:to_s)
        }

        CongressMember.
          find_or_initialize_by(bioguide_id: info["id"]["bioguide"]).
          update_attributes!(attributes)
      end

      YAML.load(social_media).each do |info|
        next unless twitter_id = info["social"]["twitter"]
        CongressMember.
          where(bioguide_id: info["id"]["bioguide"]).
          update_all(twitter_id: twitter_id)
      end
    end
  end
end
