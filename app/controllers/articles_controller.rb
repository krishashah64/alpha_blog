class ArticlesController < ApplicationController

	before_action :set_article, only: %w[edit update destroy show]
	before_action :require_user, except: %w[index show]
	before_action :require_same_user, only: %w[edit delete update]

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = 'Article Created successfully'
			redirect_to article_path(@article)
		else
			render :new
		end
	end

	def show
		respond_to do  |format|
			format.html
			format.pdf do
				pdf = ArticlePdf.new(@article)
				send_data pdf.render, file_name: "Article_#{@article.id}.pdf",
									  type: 'application/pdf',
									  disposition: 'inline'
			end
		end
	end

	def edit
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:success] = 'Article updated successfully'
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:danger] = "Article was successfully deleted"
		redirect_to articles_path
	end

	private

	def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
		if current_user != @article.user && !current_user.admin?
			flash[:danger] = 'You can only edit or delete your own articles!'
			redirect_to root_path
		end
	end
end