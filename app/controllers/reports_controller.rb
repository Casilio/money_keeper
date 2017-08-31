class ReportsController < ApplicationController
	before_action :authenticate_user!
	def new
		@ready = false	

		if params[:report]
			date_from = params[:report][:from]
			date_to = params[:report][:to]

			#TODO: clean up all this rubbish
			@balance_from = current_user.balance(date: date_from, last_include: false)
			@balance_to = current_user.balance(date: date_to)

			@income = current_user.categories.income.joins(:transactions)
				.where("event_date between ? and ?", date_from, date_to)
				.group(:name).sum(:amount)

			@income_transactions = current_user.transactions
				.where("event_date between ? and ? and categories.flow = ?", date_from, date_to, 0)

			@expense = current_user.categories.expense.joins(:transactions)
				.where("event_date between ? and ?", date_from, date_to)
				.group(:name).sum(:amount)

			@expense_transactions = current_user.transactions
				.where("event_date between ? and ? and categories.flow = ?", date_from, date_to, 1)

			@ready = true
		end	
	end
end
