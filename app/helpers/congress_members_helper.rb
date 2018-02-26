# frozen_string_literal: true
module CongressMembersHelper
  def congress_member_photo(member)
    image_tag "rep-photos/#{member.bioguide_id}.jpg"
  end
  def congress_member_chamber(member)
    "#{member.chamber}"
  end
end
