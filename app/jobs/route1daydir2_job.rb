class Route1daydir2Job

  def perform
      if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 19
        Route1daydir2Worker.perform_async('Route1daydir2Job')
      else
        $redis.set("count_1day_direction2",0)
        # 1.upto(3) do |n|
        #   puts n
        #   sleep 1
        # end
      end
  end
end
