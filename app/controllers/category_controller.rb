class CategoryController < ApplicationController
	before_action :authenticate_user!
	before_action :get_catagories
	before_action :get_category, only: [:edit, :update, :destroy]

	def index
		@category = current_user.categories.build
	end

	def create
		@category = current_user.categories.new(category_params)
		if @category.save
			flash[:success] = "Category was added"
			redirect_to category_index_path
		else
			render "index"
		end
	end


	def edit
	end

	def update
		save = @category.update_attributes(category_params)
		if save
			flash[:success] = "Category was changed"
			redirect_to category_index_path
		else
			render "edit"
		end

	end

	def destroy
		new_balance = current_user.balance(format: false).to_f - @category.amount
		if @category.flow == "income" and new_balance < 0
	        flash[:danger] = "Operation was not perform. Balance can't be less than zero."
	        redirect_to category_index_path
	    else
			@category.destroy
			flash[:success] = "Category was removed"
			redirect_to category_index_path
		end
	end

	private
		def category_params
			params.require(:category).permit(:flow, :name)	
		end

		def get_catagories
			@categories = current_user.categories.all
		end

		def get_category
			@category = Category.find(params[:id])
		end

end
