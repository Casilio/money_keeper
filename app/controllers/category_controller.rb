class CategoryController < ApplicationController
	before_action :get_flow

	def index
		@flow = current_user.categories.build
	end

	def create
		@flow = current_user.categories.new(category_params)
		unique_name_check(@flow)
		if @flow.save
			flash[:success] = "Category was added"
			redirect_to category_index_path
		else
			render "index"
		end
	end

	def destroy
		category = find_category
		category.destroy
		flash[:success] = "Category was removed"
		redirect_to category_index_path
	end

	def edit
		@category = find_category
	end

	def update
		@category = find_category
		save = @category.update_attributes(category_params)
		if save
			flash[:success] = "Category was changed"
			redirect_to category_index_path
		else
			render "edit"
		end

	end

	private
		def category_params
			params.require(:category).permit(:flow, :name)	
		end

		def get_flow
			@income_c = current_user.categories.income
			@expense_c = current_user.categories.expense
		end

		def find_category
			current_user.categories.find_by(params[:id])
		end

		def unique_name_check(category)
	    	finded = current_user.categories.find_by(name: category.name)
	    	debugger
	    	unless finded
	    		category.errors.add(:name, "Category name already in use")
	    	end
    	end
end
