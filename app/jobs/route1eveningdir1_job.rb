class Route1eveningdir1Job

  def perform
    if Time.now.strftime('%H').to_i > 18 && Time.now.strftime('%H').to_i < 23
      @route1eveningdir1 = Board.where(route_name: '1evening',route_num: 12)
      $redis.set('route1eveningdir1',@route1eveningdir1.map{ |n| n.name})
      UpdatePath.update('1evening',12,1)
    end
  end


end
