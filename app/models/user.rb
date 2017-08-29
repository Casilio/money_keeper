class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :categories, dependent: :destroy

  def name
  	self.email.split('@')[0]
  end


  def income 
  	sum = 0
  	self.categories.income.each do |category|
  		sum += category.cashes.sum(:value)
  	end
  	sum
  end

  def expense
  	sum = 0
  	self.categories.expense.each do |category|
  		sum += category.cashes.sum(:value)
  	end
  	sum
  end

  def balance(format: true)
  	if format
      "%.2f" % (income - expense)
    else
      income - expose
    end
  end
end
