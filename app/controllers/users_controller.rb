class UsersController < ApplicationController
	before_action :corrent_user

	def income

	end

	def expose
		
	end

	def report
		
	end

	private

		def corrent_user
			@user = User.find(params[:id])
			redirect_to root_path unless current_user?(@user)
		end

end
