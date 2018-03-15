# frozen_string_literal: true
ActiveAdmin.register CongressMember do
  permit_params :bioguide_id, :name, :term_end, :chamber, :state, :district,
    :twitter_id, score_attributes: [:position, :source_url]

  show do
    attributes_table do
      row :name
      row :term_end
      row :chamber
      row :state
      row :district
      row :twitter_id
    end

    panel "Position Details" do
      attributes_table_for congress_member.score do
        row :position
        row :source_url
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :term_end
      f.input :chamber
      f.input :state
      f.input :district
      f.input :twitter_id
      f.inputs do
        f.has_many :score, new_record: !f.object.score.present? do |s|
          s.input :position,
            as: :select,
            collection: Score::POSITIONS,
            default: Score::DEFAULT_POSITION,
            include_blank: false
          s.input :source_url
        end
      end
    end

    f.actions
  end
end
