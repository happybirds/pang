class Route1eveningdir2Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'route1eveningdir2'

  def perform(name)
    if Time.now.strftime('%H').to_i > 17 && Time.now.strftime('%H').to_i < 22
      @route1eveningdir1 = Board.where(route_name: '1evening',route_num: 12)
      $redis.set('route1eveningdir2',@route1eveningdir1.map{ |n| n.reverse_name})
      UpdatePath.update('1evening',12,2)
    end
  end

end
# routes,route_num,direction
