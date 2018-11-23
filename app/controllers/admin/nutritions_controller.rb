class Admin::NutritionsController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_nutrition, only: [:show, :update, :edit]

  def index
    @nutritions = Nutrition.all
    # @nutritions = @nutritions.where('title like ?', "%#{params[:title]}%") unless params[:title].blank?
    @nutritions = @nutritions.page params[:page]
  end

  def update
    if @nutrition.update(nutrition_params)
      redirect_to admin_nutritions_path, notice: '更新成功.'
    else
      render :edit
    end
  end

  def create
    @nutrition = Nutrition.new(nutrition_params)
    respond_to do |format|
      if @nutrition.save
        format.html { redirect_to admin_nutritions_path, notice: '新建成功.' }
      else
        format.html { render :new }
      end
    end
  end

	def new
		@nutrition = Nutrition.new
	end


  private
  def set_nutrition
    @nutrition = Nutrition.find_by_id(params[:id])
  end

  def nutrition_params
    params.require(:nutrition).permit([*Nutrition.attribute_names])
  end

end
