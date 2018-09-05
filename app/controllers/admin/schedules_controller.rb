class Admin::SchedulesController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_schedule, only: [:show, :update, :edit]

  def index
    @schedules = Schedule.all.order('id desc')
    # @schedules = @schedules.where('title like ?', "%#{params[:title]}%") unless params[:title].blank?
    # @schedules = @schedules.page params[:page]
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to admin_schedules_path, notice: '更新成功.'
    else
      render :edit
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to admin_schedules_path, notice: '新建成功.' }
      else
        format.html { render :new }
      end
    end
  end

	def new
		@schedule = Schedule.new
	end


  private
  def set_schedule
    @schedule = Schedule.find_by_id(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit([*Schedule.attribute_names])
  end

end
