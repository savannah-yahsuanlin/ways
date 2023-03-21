class PlaysController < ApplicationController
	before_action :find_movie, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:edit, :new]

	def index
		if params[:category].blank?
			@plays = Play.all.with_attached_image.order('created_at DESC')
		else
			@category = Category.find_by(name: params[:category]).id
			@plays = Play.where(:category_id => @category)
		end
	end

	def new
		@play = current_user.plays.build
		@categories = Category.all.map{ |c| [c.name, c.id]}
	end

	def create
		@play = current_user.plays.build(play_params)
		@play.image.attach(params[:play][:image])
		@play.category_id = params[:category_id]
		if  @play.save
			redirect_to root_path
		else 
			render 'new'
		end
	end

	def show
	end

	def edit
		@categories = Category.all.map{ |c| [c.name, c.id]}
		@play.image.attach(params[:image])
	end

	def update
		@play.category_id = params[:category_id]
		@play.image.attach(params[:play][:image])
		if @play.update(play_params)
			redirect_to play_path(@play)
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
		params.require(:play).permit(:title, :description, :director, :category_id, :image)
	end

	def find_movie
		@play = Play.find(params[:id])
	end

	
end
