class Rep < ApplicationRecord
  has_one :score, dependent: :destroy
  accepts_nested_attributes_for :score
  delegate :position, :source_url, :to => :score
end

