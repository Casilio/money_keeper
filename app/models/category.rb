class Category < ApplicationRecord
	enum flow: [:income, :expense]
	validates :name, presence: true, 
				length: { minumum: 3, maximum: 250 }

	validates :flow, presence: true
	validates :user, presence: true

 	belongs_to :user
    has_many :cashes, dependent: :destroy
end
