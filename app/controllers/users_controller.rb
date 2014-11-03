class UsersController < ApplicationController
	load_and_authorize_resource only: [:edit, :update, :destroy]
	before_filter :authenticate!, only: [:edit, :update, :destroy]

	def index
		@users = User.includes(:profile).page(params[:page])
	end

	def new
		@user = User.new
		@profile = Profile.new
	end
	
	def create
		@user = User.new user_params
		@profile = Profile.new profile_params

		if @user.valid? 
			@user.profile = @profile 
			@user.save
			user_session.start_session @user
			flash[:success] = "Account created and logged in successfully"
			redirect_to root_url
		else
			@profile.valid? # still a code smell!
			flash[:error] = 'Oops, there was an error'
			render :new
		end
	end

	def edit
		@profile = @user.profile || Profile.new
	end

	def update
		@user.build_profile

		@user.assign_attributes user_params
		@user.profile.assign_attributes profile_params

		if @user.valid? && @user.profile.valid?
			@user.save
			flash[:success] = "Updated profile successfully"
			redirect_to users_path
		else
			@user.profile.valid
			@profile = @user.profile

			flash[:error] = 'Oops, there was a problem...'
			render :edit
		end
	end

	def destroy
		logout = current_user.id == user.id
		@user.destroy
		user_session.destroy_session if logout

		flash[:success] = "Your account has been deleted successfully!"
		redirect_to users_path
	end

	private

	def user
		@user ||= User.find params[:id]
	end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def profile_params
      params.require(:profile).permit(:age, :avatar_file_name, :name)
    end 
end