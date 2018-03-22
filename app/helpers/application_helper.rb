# frozen_string_literal: true
module ApplicationHelper
  def tracking_image(piwik_id, js: false)
    base_url = "https://anon-stats.eff.org/js/?"
    params = {
      idsite: piwik_id,
      rec: 1
    }
    params[:urlref] = "REFERRER" if js
    image_tag(base_url + params.to_query, style: "border:0", alt: "")
  end

  def active_link_class(path)
    "active" if current_page?(path)
  end
end
