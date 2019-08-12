class Admin::SettingController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_page, only: [:show, :update, :edit,:transfor]

  def index
    @pages = Page.all
    @pages = @pages.page params[:page]
  end

  def transfor_all
    pages = Page.all

    pages.each do |page|
      pri = 0
      glo = 0  
      page.app_settings.each do |setting|
        if setting.name.include? 'system'
          glo += 1
        else
          if(setting.pages.count < 2 ) 
            pri += 1
          else
            glo += 1
          end
        end
      end

      page.update(global: glo,private: pri)

    end

    redirect_to admin_setting_path

  end

  def transfor
    settings = AppSetting.all
    @page.page_settings.destroy_all
    ary=[]
    a=[]
    settings.each do |s|
      # if(ary.include? s.name)
      #   a << s.name
      # else
      #   ary << s.name
      # end
       if @page.content.include? s.name
         # ary << s.name
          PageSetting.create(page_id: @page.id,app_setting_id: s.id)
       end

    end

    redirect_to admin_setting_path

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
        format.html { redirect_to admin_pages_path, notice: '新建成功.' }
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
