class CategoryController < ApplicationController
	before_action :get_catagories

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

		def get_catagories
			@categories = current_user.categories.all
		end

		def find_category
			Category.find(params[:id])
		end

end
