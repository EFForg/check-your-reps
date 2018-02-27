# frozen_string_literal: true
module ApplicationHelper
  def js_tracking_image(piwik_id)
    url = "https://anon-stats.eff.org/js?" + {
      idsite: piwik_id,
      rec: 1,
      urlref: "REFERRER"
    }.to_query
    image_tag(url, style: "border:0", alt: "")
  end
end
