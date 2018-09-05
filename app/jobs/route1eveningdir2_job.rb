class Route1eveningdir2Job

  def perform
    Rails.logger.debug "Route1eveningdir2Job-----start---- #{Time.now}"
    @route1eveningdir1 = Board.where(route_name: '1evening',route_num: 12)
    $redis.set('route1eveningdir2',@route1eveningdir1.map{ |n| n.reverse_name})
    UpdatePath.update('1evening',1,2)
    Rails.logger.debug "Route1eveningdir2Job-----end---- #{Time.now}"
  end

end
# routes,route_num,direction
