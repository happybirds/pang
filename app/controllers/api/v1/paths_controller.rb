class  Api::V1::PathsController <  Api::V1::ApplicationController
  def r1daydir1
  	@routes = Board.where(route_name: '1day',route_num: 1)
  	@distance_1day_direction1 =  $redis.get("distance_1day_direction1") || []
		@distance_1day_direction1_true =  $redis.get("distance_1day_direction1_true")|| []
		 # @count_1day_direction1 =  $redis.get("count_1day_direction1")|| 0
  	render json: {result: @routes, bus: @distance_1day_direction1}
  end
  def r1daydir2
		@routes = Board.where(route_name: '1day',route_num: 1).order('sort desc')
		@distance_1day_direction2 =  $redis.get("distance_1day_direction2")|| []
		render json:  {result: @routes, bus: @distance_1day_direction2}
  end

  def r1eveningdir1
		@routes =  Board.where(route_name: '1evening',route_num: 12)
	 	@distance_1evening_direction1 =  $redis.get("distance_1evening_direction1")|| []
		render json:  {result: @routes, bus: @distance_1evening_direction1}
  end
  def r1eveningdir2
		@routes =  Board.where(route_name: '1evening',route_num: 12).order('sort desc')
		@distance_1evening_direction2 =  $redis.get("distance_1evening_direction2")|| []
		render json:  {result: @routes, bus: @distance_1evening_direction2}
  end
  def r2daydir1
		@routes = Board.where(route_name: '2day',route_num: 2)
		@distance_2day_direction1 =  $redis.get("distance_2day_direction1") || []
		render json:  {result: @routes, bus: @distance_2day_direction1}
  end

  def r3daydir1
		@routes = Board.where(route_name: '3day',route_num: 3)
		@distance_3day_direction1 =  $redis.get("distance_3day_direction1") || []
		render json:  {result: @routes, bus: @distance_3day_direction1}
  end

   def count
		@count_1day_direction1 =  $redis.get("count_1day_direction1")|| 0
		@count_1day_direction2 =  $redis.get("count_1day_direction2")|| 0
		@count_1evening_direction1 =  $redis.get("count_1evening_direction1")|| 0
		@count_1evening_direction2 =  $redis.get("count_1evening_direction2")|| 0	
 		@count_2day_direction1 =  $redis.get("count_2day_direction1")|| 0
		@count_3day_direction1 =  $redis.get("count_3day_direction1")|| 0	
  	render json: {r1daydir1: @count_1day_direction1,r1daydir2: @count_1day_direction2,r1eveningdir1: @count_1evening_direction1,
  		r1eveningdir2: @count_1evening_direction2,r2daydir1: @count_2day_direction1,r3daydir1: @count_3day_direction1}
  end

end