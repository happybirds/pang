class Route3daydir1Job

  def perform
      # @route3daydir1 = Board.where(route_name: '3day',route_num: 3)
      # $redis.set('route3daydir1',@route3daydir1.map{ |n| n.name})
      #
      # UpdatePath.update('3day',3,1)
      # Rails.logger.info "Route3dir1Job-----start---- #{Time.now}"
      Route3daydir1Worker.perform_async('Route3daydir1Job')
      sleep(5)
  end


end
