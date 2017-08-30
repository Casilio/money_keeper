class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :categories, dependent: :destroy
  has_many :transactions, through: :categories, source: :transactions

  def name
  	self.email.split('@')[0]
  end


  def income 
  	self.categories.income.joins(:transactions).sum(:amount) 
  end

  def expense
    self.categories.expense.joins(:transactions).sum(:amount)
  end

  def balance(format: true)
  	if format
      "%.2f" % (income - expense)
    else
      income - expose
    end
  end
end
