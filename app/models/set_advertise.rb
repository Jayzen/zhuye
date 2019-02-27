class SetAdvertise < ApplicationRecord
  belongs_to :user, optional: true

  validates :map_height, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
end
