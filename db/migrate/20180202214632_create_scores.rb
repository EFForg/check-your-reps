class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :reps do |t|
      t.string :name, required: true
      t.string :bioguide_id, required: true
      t.date :term_end, required: true
      t.string :chamber, required: true
      t.string :state, required: true
      t.integer :district
    end

    create_table :scores do |t|
      t.string :position
      t.string :source_url
      t.references :rep
    end
  end
end
