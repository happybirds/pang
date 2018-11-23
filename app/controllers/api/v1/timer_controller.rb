class Api::V1::TimerController < Api::V1::ApplicationController
	def timer
		times = BusTime.where(board_id: params[:board_id])
		render json: {times: times}
	end
end
