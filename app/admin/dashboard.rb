# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    panel "Congress Members without positions" do
      missing = CongressMember.current.without_scores

      if missing.empty?
        div class: "blank_slate_container", id: "dashboard_default_message" do
          span class: "blank_slate" do
            text_node "All congress members have scores. Nice."
          end
        end
      else
        table_for missing.map do
          column(:name) do |rep|
            if rep.score
              link_to(rep.name, edit_admin_score_path(rep.score))
            else
              link_to(rep.name, new_admin_score_path)
            end
          end
          column :state
          column :chamber
          column :bioguide_id
        end
      end
    end
  end
end
