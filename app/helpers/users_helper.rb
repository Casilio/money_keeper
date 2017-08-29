module UsersHelper
	
	def current_user?(user)
		current_user == user		
	end

	def currency(value)
    	"%.2f $" % value
 	end
end
