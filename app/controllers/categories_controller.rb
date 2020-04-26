class CategoriesController < ApplicationController

	before_action :require_admin, except: %w[index show]

	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = 'Category is created successfully'
			redirect_to categories_path
		else
			render :new
		end
	end

	def show
		@category = Category.find(params[:id])
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
			flash[:success] = 'Category updated successfully'
			redirect_to categories_path
		else
			render :edit
		end
	end

	def destroy
		@category.destroy
		flash[:success] = 'Category deleted successfully'
		redirect_to categories_path
	end

	private

	def set_category
		@category = Category.find(params[:category_id])
	end

	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin

		if !logged_in? || (logged_in? and !current_user.admin?)
			flash[:danger] = "Only admins can perform that action"
			redirect_to categories_path
		end

	end

end