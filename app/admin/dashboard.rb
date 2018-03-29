# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    panel "Congress Members without positions" do
      missing = CongressMember.current.joins(:score).where(scores: { position: [nil, ''] })

      if missing.empty?
        text_node "All congress members have scores. Nice."
      else
        table_for missing.map do
          column(:name) { |rep| link_to(rep.name, edit_admin_score_path(rep.score)) }
          column :state
          column :chamber
          column :bioguide_id
        end
      end
    end
  end
end
