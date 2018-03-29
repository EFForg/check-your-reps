# frozen_string_literal: true
class Score < ApplicationRecord
  DEFAULT_POSITION = "Uncommitted"
  POSITIONS = (%w(Yes No) << DEFAULT_POSITION).freeze
  NULL_POSITIONS = [nil, '']

  belongs_to :congress_member
  validates_uniqueness_of :congress_member
  validates_inclusion_of :position, in: POSITIONS, allow_blank: true

  # Note: it's possible to do this kind of scope negation with subqueries:
  # `scope :not_original, -> { where.not(id: original) }`
  # However that takes much longer, since it has to find all the models
  # with attr: x, get their ids, and then find all the models with id: not_those.
  # So, just keep these in sync.
  scope :with_position, -> { where.not(position: NULL_POSITIONS) }
  scope :without_position, -> { where(position: NULL_POSITIONS) }

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
