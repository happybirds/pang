class Route1daydir1Job

  def perform
    if Time.now.strftime('%H').to_i >= 7 && Time.now.strftime('%H').to_i <= 19
      @route1daydir1 = Board.where(route_name: '1day',route_num: 1)
      $redis.set('route1daydir1',@route1daydir1.map{ |n| n.name})
      UpdatePath.update('1day',1,1)
    end
  end


end
