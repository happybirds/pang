class Route2daydir1Job

  def perform
    Rails.logger.info "Route2dir1Job-----start---- #{Time.now}"
    @route2daydir1 = Board.where(route_name: '2day',route_num: 2)
    $redis.set('route2daydir1',@route2daydir1.map{ |n| n.name})

    UpdatePath.update('2day',2,1)
    Rails.logger.info "Route2dir1Job-----start---- #{Time.now}"
  end

# routes,route_num,direction
end
