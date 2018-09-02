class ArticlesController < ApplicationController
	def index
		@articles = Article.all.page(params[:page]).per(8)
	end
	
	def show
		@article = Article.find_by_id params[:id]
	end

end