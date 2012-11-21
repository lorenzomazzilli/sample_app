class UsersController < ApplicationController
	before_filter	:signed_in_user, 	only: [:index, :edit, :update]
	before_filter	:correct_user,		only: [:edit, :update]
	before_filter	:admin_user,		only: [:destroy]
	before_filter	:prevent_admin_suicide,		only: [:destroy]
	before_filter	:already_existing_user,		only: [:create, :new]


	def new
    @user = User.new
  end
  
  def show
	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def index
	@users = User.paginate(page: params[:page])
  end	

  def create
	@user = User.new(params[:user])
	if @user.save
		sign_in(@user)
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	else
		render 'new'
	end
  end
  
  def edit
  end
  
  def update
	if(@user.update_attributes(params[:user]))
		flash[:success]= "Profile update"
		sign_in @user
		redirect_to @user
	else
		render 'edit'
	end	
  end
  
  def destroy
    @user_to_destroy.destroy
	flash[:success] = "User correctly deleted"
	redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end  
  
  private

	
	def correct_user
		@user = User.find(params[:id])
		redirect_to (root_path) unless current_user?(@user)
	end
	
	def admin_user
		redirect_to root_path unless current_user.admin?
	end

	def prevent_admin_suicide
		@user_to_destroy = User.find(params[:id])
		if current_user?(@user_to_destroy)
			flash[:notice] = "cannot destry yourself"
			redirect_to users_path 
		end
	end

	
	def already_existing_user
		redirect_to root_path unless !signed_in?
	end
end
