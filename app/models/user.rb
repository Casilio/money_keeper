class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :categories, dependent: :destroy
  has_many :cashes, through: :categories, source: :cashes

  def name
  	self.email.split('@')[0]
  end


  def income 
  	self.categories.income.joins(:cashes).sum(:value) 
  end

  def expense
    self.categories.expense.joins(:cashes).sum(:value)
  end

  def balance(format: true)
  	if format
      "%.2f" % (income - expense)
    else
      income - expose
    end
  end
end
