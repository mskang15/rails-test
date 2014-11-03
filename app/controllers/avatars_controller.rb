class AvatarsController < ApplicationController
	before_filter :authenticate!
	before_filter :user

	def edit
		
	end

	def update
		if params[:profile][:avatar].present?
			if user.profile.update_attributes profile_params
				flash[:success] = "File uploaded successfully"
			else
				flash[:error] = "Something went wrong with the upload"
			end
		else
			flash[:error] = "No file provided"
		end

		redirect_to edit_avatar_path(user)
	end

	def destroy
		if user.profile.avatar?
			user.profile.avatar = nil
			user.profile.save
			flash[:success] = "File deleted successfully"
		else
			flash[:success] = "There was no avatar to delete"
		end

		redirect_to edit_avatar_path(user)
	end

	private

	def user
		@user ||= User.find params[:id]
	end

	def profile_params
      params.require(:profile).permit(:age, :avatar_file_name, :name)
    end
end
