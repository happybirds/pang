class PathsController < ApplicationController
	def index
		@route1daydir1 = Board.where(route_name: '1day',route_num: 1)
		@route1daydir2 = Board.where(route_name: '1day',route_num: 1).order('sort desc')
		@route1eveningdir1 = Board.where(route_name: '1evening',route_num: 12)
		@route1eveningdir2 = Board.where(route_name: '1evening',route_num: 12).order('sort desc')
		@route2daydir1 = Board.where(route_name: '2day',route_num: 2)
		@route3daydir1 = Board.where(route_name: '3day',route_num: 3)
	end

	def change
		 if params[:num].to_i == 1
			 @routes = Board.where(route_name: '1day',route_num: 1)
			 @class_name = 'route1daydir1'
		 elsif params[:num].to_i == 2
			 @routes = Board.where(route_name: '1day',route_num: 1).order('sort desc')
			 @class_name = 'route1daydir2'
		 elsif params[:num].to_i == 3
			 @routes = Board.where(route_name: '1evening',route_num: 12)
			 @class_name = 'route1eveningdir1'
		 elsif params[:num].to_i == 4
			 @routes = Board.where(route_name: '1evening',route_num: 12).order('sort desc')
			 @class_name = 'route1eveningdir2'
		 elsif params[:num].to_i == 5
			 @routes = Board.where(route_name: '2day',route_num: 2)
			 @class_name = 'route2daydir1'
		 elsif params[:num].to_i == 6
			 @routes = Board.where(route_name: '3day',route_num: 3)
			 @class_name = 'route3daydir1'
		 end

	end

	 def distance
     @distance_1day_direction1 =  $redis.get("distance_1day_direction1") || []
		 @distance_1day_direction1_true =  $redis.get("distance_1day_direction1_true")|| []
		 @count_1day_direction1 =  $redis.get("count_1day_direction1")|| 0

		 @distance_1day_direction2 =  $redis.get("distance_1day_direction2")|| []
		 @distance_1day_direction2_true =  $redis.get("distance_1day_direction2_true")|| []
		 @count_1day_direction2 =  $redis.get("count_1day_direction2")|| 0

	  @distance_1evening_direction1 =  $redis.get("distance_1evening_direction1")|| []
		@distance_1evening_direction1_true =  $redis.get("distance_1evening_direction1_true")|| []
		@count_1evening_direction1 =  $redis.get("count_1evening_direction1")|| 0



		@distance_1evening_direction2 =  $redis.get("distance_1evening_direction2")|| []
		@distance_1evening_direction2_true =  $redis.get("distance_1evening_direction2_true")|| []
		@count_1evening_direction2 =  $redis.get("count_1evening_direction2")|| 0

		@distance_2day_direction1 =  $redis.get("distance_2day_direction1") || []
 	  @distance_2day_direction1_true =  $redis.get("distance_2day_direction1_true")|| []
		 @count_2day_direction1 =  $redis.get("count_2day_direction2")|| 0

	  @distance_3day_direction1 =  $redis.get("distance_3day_direction1") || []
  	@distance_3day_direction1_true =  $redis.get("distance_3day_direction1_true")|| []
	  @count_3day_direction1 =  $redis.get("count_3day_direction1")|| 0







		@no_sign_1day = $redis.get("no_sign_1day")|| []
		@no_sign_1evening = $redis.get("no_sign_1evening")|| []
		@no_sign_2day = $redis.get("no_sign_2day")|| []
		@no_sign_3day = $redis.get("no_sign_3day")|| []

	 end
end
