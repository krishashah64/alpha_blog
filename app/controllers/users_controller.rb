class UsersController < ApplicationController

	before_action :set_user, only: %w[show edit destroy update]
	before_action :require_user, only: %w[show index]
	before_action :require_same_user, only: %w[edit update destroy]
	before_action :require_admin, only: [:destroy]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "#{@user.name}, welcome to Alpha Blog!"
			redirect_to user_path(@user)
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "Your details are successfully updated!"
			redirect_to root_path
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		flash[:success] = "#{@user.name}'s account and all articles for this account are deleted successfully"
		redirect_to root_path
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end

	def require_same_user
		if current_user != @user and !current_user.admin?
			flash[:danger] = 'You can only edit your own account!'
			redirect_to root_path
		end
	end

	def require_admin
		if logged_in? && !current_user.admin?
			flash[:danger] = 'Only admins can Delete an account'
			redirect_to root_path
		end
	end

end