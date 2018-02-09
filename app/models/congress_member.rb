class CongressMember < ApplicationRecord
  has_one :score, dependent: :destroy
  accepts_nested_attributes_for :score
  delegate :position, :source_url, to: :score

  validates_uniqueness_of :bioguide_id

  default_scope { order(name: :asc) }
  scope :current, -> { where("? <= term_end", Time.now) }
  scope :without_scores, -> { left_outer_joins(:score).where(scores: { id: nil }) }

  def self.lookup(street, zipcode)
    state, district = SmartyStreets.get_congressional_district(street, zipcode)
    if state && district
      current.where(state: state).where("chamber = ? OR district = ?", "senate", district)
    end
  end
end
