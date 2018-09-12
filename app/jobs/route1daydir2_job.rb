class Route1daydir2Job

  def perform
      # @route1daydir1 = Board.where(route_name: '1day',route_num: 1)
      # $redis.set('route1daydir2',@route1daydir1.map{ |n| n.reverse_name})
      # UpdatePath.update('1day',1,2)
      Route1daydir2Worker.perform_async('Route1daydir2Job')
      sleep(5)
  end

end
# routes,route_num,direction
