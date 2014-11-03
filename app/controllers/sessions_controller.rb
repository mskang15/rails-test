class SessionsController < ApplicationController
	def new
		
	end

	def create
		@user = User.where(email: params[:email]).first
		auth = UserAuthenticator.new @user

		if auth.authenticate params[:password]
			user_session.start_session @user
			flash[:success] = 'Logged in successfully'
			redirect_to root_url
		else
			flash[:error] = 'Invalid email or password'
			render :new
		end
	end

	def destroy
		user_session.destroy_session
		flash[:success] = 'Logged out successfully'
		redirect_to root_url
	end
	
end