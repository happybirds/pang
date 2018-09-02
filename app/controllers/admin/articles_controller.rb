class Admin::ArticlesController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_article, only: [:show, :update, :edit]

  def index
    @articles = Article.all.order('id desc')
    @articles = @articles.where('title like ?', "%#{params[:title]}%") unless params[:title].blank?
    @articles = @articles.page params[:page]
  end

  def update
    if @article.update(article_params)
      redirect_to admin_articles_path, notice: '更新成功.'
    else
      render :edit
    end
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_path, notice: '新建成功.' }
      else
        format.html { render :new }
      end
    end
  end

	def new
		@article = Article.new
	end


  private
  def set_article
    @article = Article.find_by_id(params[:id])
  end

  def article_params
    params.require(:article).permit([*Article.attribute_names])
  end

end
