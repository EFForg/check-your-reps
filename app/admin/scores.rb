# frozen_string_literal: true
ActiveAdmin.register Score do
  permit_params :position, :source_url, :congress_member_id

  form do |f|
    f.inputs do
      input :congress_member_id,
        as: :select,
        collection: CongressMember.current.without_scores,
        include_blank: false
      input :position,
        as: :select,
        collection: Score::POSITIONS,
        default: Score::DEFAULT_POSITION,
        include_blank: false
      input :source_url
    end

    f.actions
  end
end
