class Category < ApplicationRecord
  enum flow: [:income, :expense]
  validates :name,
    presence: true,
    length: { minumum: 3, maximum: 250 }

  validates :flow,
    presence: true,
    uniqueness: { scope: [:user_id, :flow], message: 'name already in use' }
  validates :user, presence: true

  belongs_to :user
  has_many :transactions, dependent: :destroy

  def amount
    self.transactions.sum(:amount)
  end
end

