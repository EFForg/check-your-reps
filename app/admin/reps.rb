ActiveAdmin.register Rep do
  permit_params :name, :bioguide_id,
    score_attributes: [:position, :source_url]

  controller do
    def new
      @rep = Rep.new
      @rep.build_score
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :bioguide_id, label: "Bioguide ID"
      f.input :position
      f.input :source_url
    end

    f.actions
  end

end
