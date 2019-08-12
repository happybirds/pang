class Admin::AppSettingsController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_app_setting, only: [:show, :update, :edit]

  def index
    @app_settings = AppSetting.all
    @app_settings = @app_settings.page params[:page]
  end

  def update
    if @app_setting.update(app_setting_params)
      redirect_to admin_app_settings_path, notice: '更新成功.'
    else
      render :edit
    end
  end

  def create
    @app_setting = AppSetting.new(app_setting_params)
    respond_to do |format|
      if @app_setting.save
        format.html { redirect_to admin_setting_path, notice: '新建成功.' }
      else
        format.html { render :new }
      end
    end
  end

	def new
		@app_setting = AppSetting.new
	end


  private
  def set_app_setting
    @app_setting = AppSetting.find_by_id(params[:id])
  end

  def app_setting_params
    params.require(:app_setting).permit([*AppSetting.attribute_names])
  end

end
