class MeetupsController < ApplicationController
	authorize_resource only: [:new, :show, :edit, :update, :destroy]
	before_filter :meetup, only: [:show, :edit, :update, :destroy]
	helper_method :meetup

	def index
		@meetups = Meetup.all
	end

	def new
		@meetup = Meetup.new
	end

	def create
		@meetup = Meetup.new meetup_params


		if @meetup.save
			flash[:success] = 'Successfully create Meetup'
			redirect_to meetups_path
		else
			flash[:error] = 'Ooops, there was a problem...'
			render :new
		end
	end

	def show
		@meetup = Meetup.find params[:id]
	end

	def edit
		
	end

	def update
		if @meetup.update_attributes(meetup_params)
			flash[:success] = 'Sucessfully updated Meetup'
			redirect_to meetups_path
		else 
			flash[:error] = 'Ooops there was a problem.'
			redirect_to meetups_path
		end

	end

	def destroy
		@meetup.destroy

		flash[:success] = 'Successfully deleted meetup'
		redirect_to meetups_path
	end

	private 

	def meetup_params
      params.require(:meetup).permit(:name, :address, :city, :state, :state, :zip, :starts_at, :ends_at, :description)
    end 

    def meetup
    	@meetup ||= Meetup.find params[:id]
    end

end
