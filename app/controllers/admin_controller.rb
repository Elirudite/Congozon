class AdminController < ApplicationController
	
	before_filter :authenticate_user!

	def users
		@users = User.all 

		if params[:permissions] == "up"
			user = User.find(params[:id])
			user.update(role: "admin")
		elsif params[:permissions] == "down"
			user = User.find(params[:id])
			user.update(role: "guest")
		end

	end


end
