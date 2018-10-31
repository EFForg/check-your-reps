# frozen_string_literal: true
module CongressMembersHelper
  def congress_member_photo(member)
    avatar = ["#{member.bioguide_id}.jpg", "default.svg"].find do |file|
      File.exist?(Rails.root.join("app/assets/images/rep-photos/#{file}"))
    end

    image_tag "rep-photos/#{avatar}"
  end
end
