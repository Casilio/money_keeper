class UsersController < ApplicationController
	before_action :corrent_user

	def report
		@income = current_user.categories
	end

	private

		def corrent_user
			@user = User.find(params[:id])
			redirect_to root_path unless current_user?(@user)
		end

end
