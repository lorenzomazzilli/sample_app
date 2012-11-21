class SitesController < ApplicationController

	before_filter	:correct_user, only: [:destroy]
	
  def new
	@site = current_user.sites.new  
  end
  
  def show

  end
  
  def index

  end	

  def create
	@site = current_user.sites.new(params[:site])
	if @site.save
		flash[:success] = "New site created! Start take over the world!"
		redirect_to current_user
	else
		render 'new'
	end
  end
  
  def edit
  end
  
  def update

  end
  
  def destroy
    @site.destroy
    redirect_to root_url
  end
  
  private
  	def correct_user
		@site = Site.find_by_id(params[:id])
		redirect_to (root_path) unless current_user?(@site.user)
	end
end