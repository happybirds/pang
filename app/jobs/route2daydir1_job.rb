class Route2daydir1Job

  def perform
        ms = ['Mon','Tue','Wed',"Thu",'Fri','Sat']
      if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 19 && ms.include?(Date.today.strftime("%a"))
        Route2daydir1Worker.perform_async('Route2daydir1Job')
      else
        $redis.set("count_2day_direction1",0)
        1.upto(3) do |n|
          puts n
          sleep 1
        end
      end

  end

end
