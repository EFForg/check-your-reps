ActiveAdmin.register Score do
  permit_params :position, :source_url, :rep_id

  form do |f|
    f.inputs do
      input :rep_id, as: :select, collection: Rep.current.without_scores
      input :position
      input :source_url
    end

    f.actions
  end
end
