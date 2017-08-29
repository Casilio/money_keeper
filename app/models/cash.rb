class Cash < ApplicationRecord
  belongs_to :category

  validates :value, presence: true, numericality: { greater_than: 0 } 
  validates :category, presence: true
  validates :description, presence: true
end
