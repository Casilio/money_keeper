class CashesController < ApplicationController
	before_action :get_categories, only: [:index, :create]
	before_action :get_transaction, only: [:destroy, :edit, :update]

	def index
		@transaction = Cash.new
	end

	def create
		@transaction = Cash.new(cash_param)
		@transaction.user = @transaction.category.user
		if @transaction.save
			flash[:success] = "Transaction was added."
			redirect_to cashes_path
		else
			render "index"
		end
	end

	def edit
		flow = @transaction.category.flow
		if flow == "income"
			@categories = current_user.categories.income
		else
			@categories = current_user.categories.expense
		end
	end

	def update
		save = @transaction.update_attributes(cash_param)
		flow = @transaction.category.flow
		if flow == "income"
			@categories = current_user.categories.income
		else
			@categories = current_user.categories.expense
		end

		if save
			flash[:success] = "Transaction was updated"
			redirect_to cashes_path
		else
			render "edit"
		end
	end

	def destroy
		@transaction.destroy
		flash[:success] = "Transaction was removed."
		redirect_to cashes_path
	end

	private

		def get_categories
			@income_c = current_user.categories.income
			@expense_c = current_user.categories.expense
		end

		def cash_param
			params.require(:cash).permit(:value, :description, :category_id, :event_date)
		end

		def get_transaction
			@transaction = Cash.find(params[:id])
		end
end
