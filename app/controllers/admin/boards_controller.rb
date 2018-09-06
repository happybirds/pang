class Admin::BoardsController < Admin::ApplicationController
  layout 'admin/application'
  before_action :set_board, only: [:show, :update, :edit]

  def index
    @boards = Board.all
    # @boards = @boards.where('title like ?', "%#{params[:title]}%") unless params[:title].blank?
    @boards = @boards.page params[:page]
  end

  def update
    if @board.update(board_params)
      redirect_to admin_boards_path, notice: '更新成功.'
    else
      render :edit
    end
  end

  def create
    @board = Board.new(board_params)
    respond_to do |format|
      if @board.save
        format.html { redirect_to admin_boards_path, notice: '新建成功.' }
      else
        format.html { render :new }
      end
    end
  end

	def new
		@board = Board.new
	end


  private
  def set_board
    @board = Board.find_by_id(params[:id])
  end

  def board_params
    params.require(:board).permit([*Board.attribute_names])
  end

end
