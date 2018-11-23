class Admin::BeansController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_bean, only: [:show, :update, :edit]

  def index
    @beans = Bean.all
    # @beans = @beans.where('title like ?', "%#{params[:title]}%") unless params[:title].blank?
    @beans = @beans.page params[:page]
  end

  def update
    if @bean.update(bean_params)
      redirect_to admin_beans_path, notice: '更新成功.'
    else
      render :edit
    end
  end

  def create
    @bean = Bean.new(bean_params)
    respond_to do |format|
      if @bean.save
        format.html { redirect_to admin_beans_path, notice: '新建成功.' }
      else
        format.html { render :new }
      end
    end
  end

	def new
		@bean = Bean.new
	end


  private
  def set_bean
    @bean = Bean.find_by_id(params[:id])
  end

  def bean_params
    params.require(:bean).permit([*Bean.attribute_names])
  end

end
