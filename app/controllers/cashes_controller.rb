class CashesController < ApplicationController
	before_action :get_categories, only: [:index, :create]

	def index
		@transaction = Cash.new
	end

	def create
		@transaction = Cash.new(cash_param)
		if @transaction.save
			flash[:success] = "Transaction was added."
			redirect_to cashes_index_path
		else
			render "index"
		end
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end

	private

		def get_categories
			@income_c = current_user.categories.income
			@expense_c = current_user.categories.expense
		end

		def cash_param
			params.require(:cash).permit(:value, :description, :category_id, :event_date)
		end
end
