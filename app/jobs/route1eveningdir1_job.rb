class Route1eveningdir1Job

  def perform
    Rails.logger.info "Route1eveningdir1Job-----start---- #{Time.now}"
    @route1eveningdir1 = Board.where(route_name: '1evening',route_num: 12)
    $redis.set('route1eveningdir1',@route1eveningdir1.map{ |n| n.name})

    UpdatePath.update('1evening',12,1)
    Rails.logger.info "Route1eveningdir1Job-----start---- #{Time.now}"
  end


end
