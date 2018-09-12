class Route2daydir1Job

  def perform
      # @route2daydir1 = Board.where(route_name: '2day',route_num: 2)
      # $redis.set('route2daydir1',@route2daydir1.map{ |n| n.name})
      #
      # UpdatePath.update('2day',2,1)
      Route2daydir1Worker.perform_async('Route2daydir1Job')
      sleep(5)
  end

# routes,route_num,direction
end
