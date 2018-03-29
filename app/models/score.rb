# frozen_string_literal: true
class Score < ApplicationRecord
  DEFAULT_POSITION = "Uncommitted"
  POSITIONS = (%w(Yes No) << DEFAULT_POSITION).freeze

  belongs_to :congress_member
  validates_uniqueness_of :congress_member
  validates_inclusion_of :position, in: POSITIONS, allow_blank: true

  scope :with_position, -> { where.not(position: [nil, '']) }

  def repair_position
    update_attribute(:position, nil) unless POSITIONS.include?(position)
  end

  def display_position
    if position == DEFAULT_POSITION
      "N/A"
    else
      position
    end
  end

  def short_position
    position[0].upcase
  end

  def self.lookup(state, district)
    all.includes(:congress_member).merge(CongressMember.lookup(state, district))
                                  .references(:congress_members)
  end
end
