class Route1daydir1Job

  def perform
    Rails.logger.info "Route1daydir1Job-----start---- #{Time.now}"
    @route1daydir1 = Board.where(route_name: '1day',route_num: 1)
    $redis.set('route1daydir1',@route1daydir1.map{ |n| n.name})
    
    UpdatePath.update('1day',1,1)
    Rails.logger.info "Route1daydir1Job-----start---- #{Time.now}"
  end


end
