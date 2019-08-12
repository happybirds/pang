class Admin::PagesController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_page, only: [:show, :update, :edit]

  def index
    @pages = Page.all
    @pages = @pages.page params[:page]
  end

  def show

      @pri = []
      @glo = []  
      @page.app_settings.each do |setting|
        if setting.name.include? 'system'
          @glo << setting.name
        else
          if(setting.pages.count < 3 ) 
            @pri << setting.name
          else
             @glo << setting.name
          end
        end
      end

     

  end

  def update
    if @page.update(page_params)
      redirect_to admin_pages_path, notice: '更新成功.'
    else
      render :edit
    end
  end

  def create
    @page = Page.new(page_params)
    respond_to do |format|
      if @page.save
        format.html { redirect_to admin_setting_path, notice: '新建成功.' }
      else
        format.html { render :new }
      end
    end
  end

	def new
		@page = Page.new
	end


  private
  def set_page
    @page = Page.find_by_id(params[:id])
  end

  def page_params
    params.require(:page).permit([*Page.attribute_names])
  end

end
