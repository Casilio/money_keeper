class Cash < ApplicationRecord
	before_save :check_balance

  belongs_to :category
  belongs_to :user

  validates :value, presence: true, numericality: { greater_than: 0 } 
  validates :category, presence: true
  validates :description, presence: true
  validates :event_date, presence: true

  private 
  	def check_balance
  		
  	end
end
