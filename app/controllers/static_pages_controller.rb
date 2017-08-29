class StaticPagesController < ApplicationController
	def index
		if user_signed_in?
			redirect_to cashes_path
		end
	end


	def about
		
	end
end
