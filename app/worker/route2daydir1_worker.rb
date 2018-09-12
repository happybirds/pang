class Route2daydir1Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'route2'

  def perform(name)
    if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 18
      @route2daydir1 = Board.where(route_name: '2day',route_num: 2)
      $redis.set('route2daydir1',@route2daydir1.map{ |n| n.name})

      UpdatePath.update('2day',2,1)
    end
  end

# routes,route_num,direction
end
