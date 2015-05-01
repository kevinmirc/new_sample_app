class AccountActivationsController < ApplicationController

	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			log_in user
			flash[:success] = "BOOM! Account activated!"
			redirect_to user
		else
			if user && user.activated?
				flash[:danger] = "Nice try, this user is already activated."
			else
				flash[:danger] = "Shucks, That's an invalid activation link."
			end
			redirect_to root_url
		end
	end
end
