class Category < ApplicationRecord
	before_save :unique_name_check

	enum flow: [:income, :expense]
	validates :name, presence: true, 
				length: { minumum: 3, maximum: 250 }

	validates :flow, presence: true
	validates :user, presence: true

 	belongs_to :user
    has_many :transactions, dependent: :destroy

    def amount
    	self.transactions.sum(:amount)
    end

	def unique_name_check
		flow = self.flow

		if flow == "income"
	    	finded = self.user.categories.income.find_by(name: self.name)
	    else
	    	finded = self.user.categories.expense.find_by(name: self.name)
	    end
	    if finded && finded != self
	    	self.errors.add(:Category, "name already in use")
	    	throw(:abort)
	    	false
	    else
	    	true
	    end
    end
end
