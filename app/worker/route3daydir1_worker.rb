class Route3daydir1Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'route3'

  def perform(name)
      @route3daydir1 = Board.where(route_name: '3day',route_num: 3)
      $redis.set('route3daydir1',@route3daydir1.map{ |n| n.name})
      UpdatePath.update('3day',3,1)
  end


end
