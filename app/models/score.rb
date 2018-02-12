class Score < ApplicationRecord
  belongs_to :congress_member
  validates_uniqueness_of :congress_member

  def self.lookup(street, zipcode)
    all.includes(:congress_member).merge(CongressMember.lookup(street, zipcode))
                                  .references(:congress_members)
  end
end
