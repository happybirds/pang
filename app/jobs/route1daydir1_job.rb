class Route1daydir1Job

  def perform
      # @route1daydir1 = Board.where(route_name: '1day',route_num: 1)
      # $redis.set('route1daydir1',@route1daydir1.map{ |n| n.name})
      # UpdatePath.update('1day',1,1)
      Route1daydir1Worker.perform_async('Route1daydir1Job')
      sleep(5)
  end


end
