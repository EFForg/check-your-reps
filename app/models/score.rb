class Score < ApplicationRecord
  belongs_to :congress_member
  validates_uniqueness_of :congress_member

  def self.lookup(state, district)
    all.includes(:congress_member).merge(CongressMember.lookup(state, district))
                                  .references(:congress_members)
  end
end
