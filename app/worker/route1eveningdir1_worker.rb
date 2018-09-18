class Route1eveningdir1Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'route1eveningdir1'

  def perform(name)
      @route1eveningdir1 = Board.where(route_name: '1evening',route_num: 12)
      $redis.set('route1eveningdir1',@route1eveningdir1.map{ |n| n.name})
      UpdatePath.update('1evening',12,1)
  end


end
