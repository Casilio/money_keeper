class StaticPagesController < ApplicationController
	def index
		if user_signed_in?
			redirect_to transactions_path
		end
	end


	def about
		
	end
end
