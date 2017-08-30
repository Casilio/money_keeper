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


  def income(date: Date.current, last_include: false)
    if last_include
  	   self.categories.income.joins(:transactions).where("event_date <= ?", date).sum(:amount)
    else
        self.categories.income.joins(:transactions).where("event_date < ?", date).sum(:amount)
    end
  end

  def expense(date: Date.current, last_include: false)
    if last_include
      self.categories.expense.joins(:transactions).where("event_date <= ?", date).sum(:amount)
    else
      self.categories.expense.joins(:transactions).where("event_date < ?", date).sum(:amount)
    end
  end

  def balance(format: true, date: Date.current, last_include: true)
    balance = (income(date: date, last_include: last_include) - expense(date: date, 
                                                                last_include: last_include))
  	if format
      "%.2f" % balance
    else
      balance
    end
  end
end
