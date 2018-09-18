class Route1daydir2Worker
  include Sidekiq::Worker
  sidekiq_options queue: 'route1daydir2'

    def perform(name)
      @route1daydir1 = Board.where(route_name: '1day',route_num: 1)
      $redis.set('route1daydir2',@route1daydir1.map{ |n| n.reverse_name})
      UpdatePath.update('1day',1,2)
    end

end
