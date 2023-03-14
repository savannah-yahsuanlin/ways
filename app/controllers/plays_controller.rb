class PlaysController < ApplicationController
	before_action :find_movie, only: [:show, :edit, :update, :destroy]

	def index
		@plays = Play.all.order('created_at ASC')
	end

	def new
		@play = Play.new
	end

	def create
		@play = Play.new(play_params)
		if  @play.save
			redirect_to root_path
		else 
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @play.update(play_params)
			redirect_to @play
		else 
			render 'edit'
		end
	end

	def destroy
		@play.destroy
		redirect_to root_path
	end

	private

	def play_params
		params.require(:play).permit(:title, :description, :director)
	end

	def find_movie
		@play = Play.find(params[:id])
	end
end