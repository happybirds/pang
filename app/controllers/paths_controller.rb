class PathsController < ApplicationController
	def index
		@route1daydir1 = Board.where(route_name: '1day',route_num: 1)
		@route1daydir2 = Board.where(route_name: '1day',route_num: 1).order('sort desc')

	end

	 def distance
     @distance_1day_direction1 =  $redis.get("distance_1day_direction1")
		 @distance_1day_direction1_true =  $redis.get("distance_1day_direction1_true")
		 # @distance_1day_direction1_finish =  $redis.get("distance_1day_direction1_finish")

		 @distance_1day_direction2 =  $redis.get("distance_1day_direction2")
		 @distance_1day_direction2_true =  $redis.get("distance_1day_direction2_true")
		 # @distance_1day_direction2_finish =  $redis.get("distance_1day_direction2_finish")

	 end
end
