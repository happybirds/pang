class Route1daydir2Job

  def perform
    Rails.logger.debug "Route1daydir2Job-----start---- #{Time.now}"
    @route1daydir1 = Board.where(route_name: '1day',route_num: 1)
    $redis.set('route1daydir2',@route1daydir1.map{ |n| n.reverse_name})
    UpdatePath.update('1day',1,2)
    Rails.logger.debug "Route1daydir2Job-----end---- #{Time.now}"
  end

end
# routes,route_num,direction
