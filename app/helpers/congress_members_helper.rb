module CongressMembersHelper
  def congress_member_photo(member)
    image_tag "rep-photos/#{member.bioguide_id}.jpg"
  end
end
