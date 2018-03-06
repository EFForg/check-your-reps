# frozen_string_literal: true
ActiveAdmin.register Score do
  permit_params :position, :source_url, :congress_member_id

  form do |f|
    f.inputs do
      input :congress_member_id,
        as: :select,
        collection: (object.persisted? ? CongressMember.current : CongressMember.current.without_scores),
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

  index do
    selectable_column
    column :id
    column :position
    column :source_url
    column :congress_member, sortable: :congress_member_id
    actions
  end

  batch_action :update_all, form: { position: Score::POSITIONS } do |ids, inputs|
    alert = if Score.where(id: ids).update_all(position: inputs['position'])
      "Positions updated."
    else
      "Some positions could not be updated"
    end
    redirect_to admin_scores_path, alert: alert
  end
end
