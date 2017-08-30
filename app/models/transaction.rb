class Transaction < ApplicationRecord

  before_save :check_balance

  belongs_to :category
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :amount, presence: true, numericality: { greater_than: 0 } 
  validates :category, presence: true
  validates :description, presence: true
  validates :event_date, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true

  self.per_page = 10

  private 
  	def check_balance
  		
  	end
end
