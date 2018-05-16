# frozen_string_literal: true
class CongressMember < ApplicationRecord
  CHAMBERS = { senate: "senate", house: "house" }

  has_one :score, dependent: :destroy
  accepts_nested_attributes_for :score
  delegate :position, :source_url, to: :score

  validates_uniqueness_of :bioguide_id
  after_create :ensure_score

  default_scope { order(name: :asc) }
  scope :current, -> { where("? <= term_end", Time.now) }
  scope :without_scores, -> {
    left_outer_joins(:score).merge(Score.without_position)
  }
  scope :house, -> { where(chamber: CHAMBERS[:house]) }
  scope :senate, -> { where(chamber: CHAMBERS[:senate]) }

  def self.lookup(state, district)
    current.where(state: state).where("chamber = ? OR district = ?", "senate", district)
  end

  def twitter_handle
    return name unless twitter_id
    twitter_id[0] == "@" ? twitter_id : "@#{twitter_id}"
  end

  def name_with_title
    if chamber == CHAMBERS[:senate]
      title = "Sen."
    else
      title = "Rep."
    end
    "#{title} #{name}"
  end

  private

  def ensure_score
    create_score unless score.present?
  end
end
