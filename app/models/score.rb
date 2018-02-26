# frozen_string_literal: true
class Score < ApplicationRecord
  DEFAULT_POSITION = "Uncommitted"
  POSITIONS = (%w(Yes No) << DEFAULT_POSITION).freeze

  belongs_to :congress_member
  validates_uniqueness_of :congress_member
  validates_inclusion_of :position, in: POSITIONS

  def repair_position
    update_attribute(:position, DEFAULT_POSITION) unless POSITIONS.include?(position)
  end

  def self.lookup(state, district)
    all.includes(:congress_member).merge(CongressMember.lookup(state, district))
                                  .references(:congress_members)
  end
end
