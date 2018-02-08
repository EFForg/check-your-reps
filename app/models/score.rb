class Score < ApplicationRecord
  belongs_to :rep
  validates_uniqueness_of :rep
end
