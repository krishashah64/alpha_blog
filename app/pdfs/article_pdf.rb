class ArticlePdf < Prawn::Document

	def initialize(article)
		super(top_margin: 70)
		@article = article
		article_desc
	end

	def article_desc
		text "Article #{@article.id}", size: 25, style: :bold
		move_down 10
		text "Title: #{@article.title}" 
		move_down 10
		text "Description: #{@article.description}"
		move_down 10
		text "Created by: #{@article.user.name}"
		move_down 10
		text "Created on: #{@article.created_at.strftime("%D")} at #{@article.created_at.strftime("%I:%M %P")}"

	end

end