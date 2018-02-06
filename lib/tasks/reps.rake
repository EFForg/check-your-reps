namespace :reps do
  desc "Create/update records of Congress members"
  task update: :environment do
    legislator_sources =
      [
        "https://raw.githubusercontent.com/unitedstates/congress-legislators/master/legislators-current.yaml",
        "https://raw.githubusercontent.com/unitedstates/congress-legislators/master/legislators-historical.yaml"
      ]

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

        Rep.
          find_or_initialize_by(bioguide_id: info["id"]["bioguide"]).
          update_attributes!(attributes)
      end
    end
  end
end
