class Transaction < ApplicationRecord

  before_save :check_balance, :check_date

  belongs_to :category
  belongs_to :user

  default_scope -> { order(event_date: :desc) }

  validates :amount, presence: true, numericality: { greater_than: 0 } 
  validates :category, presence: true
  validates :description, presence: true
  validates :event_date, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true

  self.per_page = 10

  private 
  	def check_balance
        if self.category.flow == "expense"
          if self.user.balance(format: false).to_f - self.amount < 0
            self.errors.add(:amount, "is too large")
            throw(:abort)
          end
        end
  	end

    def check_date
      current = Date.current
      if self.event_date > current
        self.errors.add(:event_date, "must be less or equal current date")
        throw(:abort)
      end
    end
end
