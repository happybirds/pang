class Route1daydir1Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'route1daydir1'

  def perform(name)
    @route1daydir1 = Board.where(route_name: '1day',route_num: 1)
    $redis.set('route1daydir1',@route1daydir1.map{ |n| n.name})
    UpdatePath.update('1day',1,1)
  end

end
